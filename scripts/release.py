#!/usr/bin/env python3
from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path
from typing import Dict, Iterable, List, Set, Tuple


def run_git(repo_root: Path, args: List[str], stdin_bytes: bytes | None = None) -> subprocess.CompletedProcess:
    return subprocess.run(
        ["git", "-C", str(repo_root), *args],
        input=stdin_bytes,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )


def find_repo_root(path: Path) -> Path:
    result = run_git(path, ["rev-parse", "--show-toplevel"])
    if result.returncode != 0:
        raise RuntimeError(
            f"{path} is not inside a Git working tree.\n"
            f"git stderr: {result.stderr.decode(errors='replace').strip()}"
        )
    return Path(result.stdout.decode().strip()).resolve()


def to_repo_relative(repo_root: Path, paths: Iterable[Path]) -> List[str]:
    rels = []
    for p in paths:
        rels.append(p.relative_to(repo_root).as_posix())
    return rels


def git_ignored_paths(repo_root: Path, paths: Iterable[Path]) -> Set[Path]:
    """
    Return the subset of `paths` that Git says are ignored.
    Paths must be logical paths inside repo_root, not resolved external targets.
    """
    path_list = list(paths)
    if not path_list:
        return set()

    rels = to_repo_relative(repo_root, path_list)
    stdin_data = ("\0".join(rels) + "\0").encode()

    result = run_git(repo_root, ["check-ignore", "-z", "--stdin"], stdin_bytes=stdin_data)

    if result.returncode not in (0, 1):
        raise RuntimeError(
            "git check-ignore failed:\n"
            f"{result.stderr.decode(errors='replace').strip()}"
        )

    ignored_rel_raw = result.stdout.decode(errors="surrogateescape")
    ignored_rel = {x for x in ignored_rel_raw.split("\0") if x}

    return {p for p, rel in zip(path_list, rels) if rel in ignored_rel}


def file_identity(path: Path) -> Tuple[int, int]:
    st = path.stat()
    return (st.st_dev, st.st_ino)


def safe_rmtree_windows(path: Path) -> None:
    def onerror(func, p, exc_info):
        try:
            os.chmod(p, 0o777)
            func(p)
        except Exception:
            raise exc_info[1]

    shutil.rmtree(path, onerror=onerror)


def copy_tree_excluding_gitignored(src: Path, dst: Path, repo_root: Path) -> None:
    if not src.is_dir():
        raise ValueError(f"Source is not a directory: {src}")

    src = src.resolve()
    repo_root = repo_root.resolve()
    dst.mkdir(parents=True, exist_ok=False)

    seen_dirs: Set[Tuple[int, int]] = set()
    seen_files: Dict[Tuple[int, int], Path] = {}

    # os.walk returns logical paths rooted under src, even when following links.
    for root, dirnames, filenames in os.walk(src, topdown=True, followlinks=True):
        logical_root = Path(root)          # keep logical tree position
        real_root = logical_root.resolve() # use only for identity / loop detection

        try:
            dir_id = file_identity(real_root)
        except OSError as e:
            print(f"Warning: cannot stat directory {logical_root}: {e}", file=sys.stderr)
            dirnames[:] = []
            continue

        if dir_id in seen_dirs:
            dirnames[:] = []
            continue
        seen_dirs.add(dir_id)

        rel_root = logical_root.relative_to(src)
        dst_root = dst / rel_root
        dst_root.mkdir(parents=True, exist_ok=True)

        # Use logical paths for git-ignore filtering.
        logical_dir_paths = [logical_root / d for d in dirnames]
        ignored_dirs = git_ignored_paths(repo_root, logical_dir_paths)
        ignored_dirs.add(src/'.git')

        dirnames[:] = [d for d in dirnames if (logical_root / d) not in ignored_dirs]

        logical_file_paths = [logical_root / f for f in filenames]
        ignored_files = git_ignored_paths(repo_root, logical_file_paths)

        for name in filenames:
            logical_file = logical_root / name
            if logical_file in ignored_files:
                continue

            dst_file = dst_root / name

            # Follow symlinks by resolving here for file identity/copy source.
            try:
                real_file = logical_file.resolve()
                file_id = file_identity(real_file)
            except OSError as e:
                print(f"Warning: cannot stat file {logical_file}: {e}", file=sys.stderr)
                continue

            first_dst = seen_files.get(file_id)
            if first_dst is not None:
                try:
                    os.link(first_dst, dst_file)
                    continue
                except OSError:
                    pass

            shutil.copy2(real_file, dst_file, follow_symlinks=True)
            seen_files[file_id] = dst_file


def build_destination_path(src: Path) -> Path:
    return src.parent / f"{src.name}_release"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Copy a directory to a sibling *_release directory, excluding gitignored files."
    )
    parser.add_argument("source", type=Path, help="Source directory")
    parser.add_argument("--force", action="store_true", help="Remove destination first if it exists")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    src = args.source.resolve()

    if not src.exists():
        print(f"Error: source does not exist: {src}", file=sys.stderr)
        return 1

    if not src.is_dir():
        print(f"Error: source is not a directory: {src}", file=sys.stderr)
        return 1

    try:
        repo_root = find_repo_root(src)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return 1

    dst = build_destination_path(src)

    if dst.exists():
        if not args.force:
            print(
                f"Error: destination already exists: {dst}\nUse --force to remove it first.",
                file=sys.stderr,
            )
            return 1
        safe_rmtree_windows(dst)

    try:
        copy_tree_excluding_gitignored(src, dst, repo_root)
    except Exception as e:
        print(f"Error while copying: {e}", file=sys.stderr)
        return 1

    print(f"Created: {dst}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())