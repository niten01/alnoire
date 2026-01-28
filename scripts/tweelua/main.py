from src.parser import parse_twee
from src.transformer import StoryTransformer
from src.emitter import LuaEmitter

if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        print(f"Usage: python {sys.argv[0]} my_story.twee")
        sys.exit(1)

    path = sys.argv[1]
    story = parse_twee(path)

    t = StoryTransformer(story)
    story = t.transform()

    emitter = LuaEmitter(story)
    lines = "\n".join(emitter.emit())
    with open("test.lua", "w", encoding="utf-8") as f:
        f.write(lines)
