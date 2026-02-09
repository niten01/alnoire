from src.parser import parse_twee
from src.transformer import StoryTransformer
from src.emitter import LuaEmitter
from src.errors import ParseError, TransformError, MergeError
from src.merge import merge
from pathlib import Path
import os

if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        print(f"Usage: python {sys.argv[0]} [my_story.twee ...]")
        sys.exit(1)

    repo_root = Path(os.path.abspath(sys.argv[0])).parent.parent.parent
    out_path = repo_root / "game/scripts/vscripts/data/dialogues.lua"

    try:
        story = parse_twee(sys.argv[1])
        for p in sys.argv[2:]:
            next_story = parse_twee(p)
            story = merge(story, next_story)
        t = StoryTransformer(story)
        story = t.transform()

        emitter = LuaEmitter(story)
        lines = "\n".join(emitter.emit())
        with open(out_path, "w", encoding="utf-8") as f:
            f.write(lines)
    except ParseError as e:
        print(f"Parsing failed!\n->Exception: {e}")
    except TransformError as e:
        print(f"Failed to transform.\n->Exception: {e}")
    except MergeError as e:
        print(f"Failed to merge.\n->Exception: {e}")
