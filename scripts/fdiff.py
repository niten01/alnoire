#!/usr/bin/env python3
from pathlib import Path
import os
import sys

def rel_entries(root: Path):
    seen, out = set(), set()
    for dirpath, dirnames, filenames in os.walk(root, followlinks=True):
        real = os.path.realpath(dirpath)
        if real in seen:
            dirnames[:] = []
            continue
        seen.add(real)

        base = Path(dirpath)
        for name in filenames:
            out.add((base / name).relative_to(root))
    return out

if len(sys.argv) != 3:
    print(f"Usage: {sys.argv[0]} DIR1 DIR2", file=sys.stderr)
    sys.exit(1)

d1, d2 = map(Path, sys.argv[1:3])
only_in_first = sorted(rel_entries(d1) - rel_entries(d2))

for p in only_in_first:
    print(p)