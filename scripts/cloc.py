from __future__ import annotations

import argparse
import tempfile
from collections import defaultdict
from pathlib import Path

from tqdm import tqdm

GLOBAL_IGNORE = [
    "game/scripts/vscripts/data/dialogues.lua",
    "game/resource/addon_english.txt",
    "game/resource/addon_russian.txt",
]


def normalize_ext(ext: str) -> str:
    ext = ext.strip().lower()
    return ext if ext.startswith(".") else f".{ext}"


def human(n: int) -> str:
    return f"{n:,}".replace(",", " ")


def load_gitignore_patterns(root: Path) -> list[tuple[Path, list[str]]]:
    entries: list[tuple[Path, list[str]]] = []
    for gitignore in root.rglob(".gitignore"):
        try:
            lines = gitignore.read_text(encoding="utf-8", errors="ignore").splitlines()
        except Exception:
            continue
        patterns = [
            line.strip()
            for line in lines
            if line.strip() and not line.lstrip().startswith("#")
        ]
        if patterns:
            entries.append((gitignore.parent, patterns))
    return sorted(entries, key=lambda x: len(x[0].parts))


def is_ignored(
    path: Path,
    root: Path,
    ignore_dirs: set[str],
    gitignores: list[tuple[Path, list[str]]],
) -> bool:
    rel = path.relative_to(root)
    rel_posix = rel.as_posix()

    if rel in map(Path, GLOBAL_IGNORE):
        return True
    if any(part in ignore_dirs for part in rel.parts):
        return True

    for base, patterns in gitignores:
        try:
            sub_rel = path.relative_to(base).as_posix()
        except ValueError:
            continue
        for pattern in patterns:
            anchored = pattern.startswith("/")
            dir_only = pattern.endswith("/")
            pat = pattern.strip("/")

            if not pat:
                continue

            target = sub_rel if anchored else rel_posix

            if dir_only:
                if (
                    pat in path.parts
                    or target.startswith(pat + "/")
                    or f"/{pat}/" in f"/{target}/"
                ):
                    return True
                continue

            if "/" in pat:
                if target == pat or target.startswith(pat + "/"):
                    return True
            else:
                if any(part == pat for part in path.parts):
                    return True
                if path.name == pat:
                    return True

    return False


def collect_files(
    root: Path,
    exts: set[str],
    ignore_dirs: set[str],
    gitignores: list[tuple[Path, list[str]]],
) -> tuple[list[Path], list[Path]]:
    files: list[Path] = []
    dirs: set[Path] = set()

    for path in tqdm(list(root.rglob("*")), desc="Searching files", leave=False):
        if is_ignored(path, root, ignore_dirs, gitignores):
            continue
        if path.is_dir():
            dirs.add(path)
            continue
        if path.is_file() and path.suffix.lower() in exts:
            files.append(path)
            dirs.add(path.parent)

    return sorted(files), sorted(dirs)


def count_file(path: Path) -> tuple[int, int]:
    try:
        lines = path.read_text(encoding="utf-8", errors="ignore").splitlines()
    except Exception:
        return 0, 0
    total = len(lines)
    non_empty = sum(1 for line in lines if line.strip())
    return total, non_empty


def format_table(rows: list[tuple[str, int, int, int]]) -> str:
    headers = ("Extension", "Files", "Lines", "Non-empty")
    rendered = [(a, human(b), human(c), human(d)) for a, b, c, d in rows]
    widths = [
        max(len(headers[i]), *(len(row[i]) for row in rendered)) for i in range(4)
    ]
    sep = "  "
    out = [
        sep.join(headers[i].ljust(widths[i]) for i in range(4)),
        sep.join("-" * widths[i] for i in range(4)),
    ]
    out += [
        sep.join(
            [
                row[0].ljust(widths[0]),
                row[1].rjust(widths[1]),
                row[2].rjust(widths[2]),
                row[3].rjust(widths[3]),
            ]
        )
        for row in rendered
    ]
    return "\n".join(out)


def dump_dirs(dirs: list[Path]) -> Path:
    fd, tmp = tempfile.mkstemp(prefix="scanned_dirs_", suffix=".txt")
    out = Path(tmp)
    with out.open("w", encoding="utf-8") as f:
        for d in dirs:
            f.write(str(d) + "\n")
    return out


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("directory", type=Path)
    parser.add_argument("-e", "--extensions", nargs="+", default=["py", "lua", "txt"])
    parser.add_argument(
        "--ignore-dir",
        nargs="*",
        default=[".git", ".venv", "venv", "__pycache__"],
    )
    args = parser.parse_args()

    root = args.directory.expanduser().resolve()
    exts = {normalize_ext(ext) for ext in args.extensions}
    ignore_dirs = set(args.ignore_dir)
    gitignores = load_gitignore_patterns(root)

    files, dirs = collect_files(root, exts, ignore_dirs, gitignores)

    by_ext = defaultdict(lambda: {"files": 0, "lines": 0, "non_empty": 0})

    for path in tqdm(files, desc="Scanning files", unit="file", leave=False):
        total, non_empty = count_file(path)
        ext = path.suffix.lower()
        by_ext[ext]["files"] += 1
        by_ext[ext]["lines"] += total
        by_ext[ext]["non_empty"] += non_empty

    rows = sorted(
        (ext, stats["files"], stats["lines"], stats["non_empty"])
        for ext, stats in by_ext.items()
    )

    total_files = sum(r[1] for r in rows)
    total_lines = sum(r[2] for r in rows)
    total_non_empty = sum(r[3] for r in rows)
    dump_path = dump_dirs(dirs)

    print()
    print(f"Directory:   {root}")
    print(f"Extensions:  {', '.join(sorted(exts))}")
    print(f"Files:       {human(total_files)}")
    print(f"Directories: {human(len(dirs))}")
    print(f"Dirs dump:   {dump_path}")
    print()
    print(format_table(rows + [("TOTAL", total_files, total_lines, total_non_empty)]))


if __name__ == "__main__":
    main()
