import os
from pathlib import Path
import sys

content_dir = Path(os.path.abspath(sys.argv[0])).parent.parent / "content"
hlup_dir = content_dir / "sounds/music/hlups"
for f in os.listdir(hlup_dir):
    fp = hlup_dir / f
    print(f"\t{fp.stem} = {{")
    print('\t\ttype = "dota_update_battle_music"')
    print("\t\tvsnd_files = ")
    print("\t\t[")
    print(f'\t\t\t"{os.path.relpath(fp,content_dir).replace('wav','vsnd')}"')
    print("\t\t]")
    print('\t\tvolume = "2.5"')
    print('\t}')
