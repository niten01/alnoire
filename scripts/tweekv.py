import re
from dataclasses import dataclass, field
from typing import List, Dict

import pytwee
from pytwee.story import Story as PytweeStory
from pytwee.twee3 import Parser as PytweeParser
from transliterate import translit

##################################################################################


@dataclass
class Link:
    raw: str
    display: str | None
    target: str


@dataclass
class Passage:
    name: str
    tags: List[str] = field(default_factory=list)
    raw_text: str = ""
    links: List[Link] = field(default_factory=list)

    def __repr__(self) -> str:
        return (
            f"<Passage name={self.name!r} tags={self.tags!r} links={len(self.links)}>"
        )

    def text(self) -> str:
        return self.raw_text


@dataclass
class Story:
    title: str | None = None
    passages: Dict[str, Passage] = field(default_factory=dict)

    def add(self, passage: Passage):
        self.passages[passage.name] = passage

    def get(self, name: str) -> Passage | None:
        return self.passages.get(name)

    def rename(self, old: str, new: str):
        if old not in self.passages:
            raise KeyError(f"passage {old!r} not found")

        p = self.passages.pop(old)
        p.name = new
        self.passages[new] = p

        for other in self.passages.values():
            for link in other.links:
                if link.target == old:
                    link.target = new


LINK_RE = re.compile(r"\[\[(?:(?P<display>.*?)(?:->|\|))?(?P<target>.*?)\]\]")


def extract_links(text: str) -> tuple[str, List[Link]]:
    links: List[Link] = []
    # for m in LINK_RE.finditer(text):
    #     raw = m.group(0)
    #     display, target = m.group("display"), m.group("target")
    #     display = display or target

    #     links.append(Link(raw=raw, display=display, target=target.strip()))

    text_content = ""
    for line in text.split("\n"):
        if len(line) == 0 or line == "\n":
            continue
        m = LINK_RE.match(line)
        if m:
            raw = m.group(0)
            display, target = m.group("display"), m.group("target")
            display = display or target

            links.append(Link(raw=raw, display=display, target=target.strip()))
        else:
            text_content += line
    return text_content, links


def parse_twee(filepath: str, story: Story | None = None) -> Story:
    story = story or Story()
    pytwee_story = PytweeStory()

    parser = PytweeParser(pytwee_story)
    with open(filepath, "r", encoding="utf-8") as f:
        for line in f:
            parser(line.rstrip("\n"))
    del parser

    if pytwee_story.title:
        story.title = pytwee_story.title

    num_links = 0
    for p in pytwee_story.passages:
        raw = p.context or ""
        text, links = extract_links(raw)
        num_links += len(links)
        passage = Passage(
            name=p.header.name, tags=p.header.tags or [], raw_text=text, links=links
        )
        story.add(passage)

    print(f"Parsed {len(story.passages)} passages with {num_links} links.")
    return story


#####################################################################################


class LuaConverter:
    def __init__(self, story: Story):
        self.story = story
        self.node_id_counter: dict[str, int] = {}
        self.entries = {}
        self.nodes = {}

    def _gen_node_id(self, name):
        node_id: str = translit(name, language_code="ru", reversed=True)
        node_id = re.sub(r"\s+", "_", re.sub(r"[^a-z\s\d]", "", node_id.lower()))
        node_id = node_id.strip("_")
        if len(node_id) == 0:
            node_id = "empty"
        node_id = "d_" + node_id

        if node_id in self.node_id_counter:
            self.node_id_counter[node_id] += 1
            node_id += f"__{self.node_id_counter[node_id]}"
        else:
            self.node_id_counter[node_id] = 0
        return node_id

    def convert(self) -> tuple[dict, dict]:
        for name in list(self.story.passages.keys()):
            node_id = self._gen_node_id(name)
            self.story.rename(name, node_id)

        for id, passage in self.story.passages.items():
            if id in self.nodes:
                print(
                    f"Duplicate passages found:\n{passage}\n{'Against '+'-'*10}{self.nodes[id]}\nThis should not happen"
                )
                exit(1)
            self.nodes[id] = {
                "text": passage.text(),
                "choices": [
                    {
                        "text": link.display,
                        "next": link.target,
                    }
                    for link in passage.links
                ],
            }
        return self.entries, self.nodes


class LuaEmitter:
    def __init__(self, entries: dict, nodes: dict):
        self.entries = entries
        self.nodes = nodes

    def emit(self):
        lines = []
        lines.append("""local QuestStatus = require('modules.quest.quest_status')""")
        lines.append("return {")

        lines.append("nodes = {")

        for id, node in self.nodes.items():
            lines.append(f"{id} = {{")
            lines.append(f"text = [[{node['text']}]],")
            lines.append("choices = {")
            for choice in node["choices"]:
                lines.append(
                    f'{{ text = [[{choice['text']}]], next = "{choice['next']}" }},'
                )
            lines.append("},")
            lines.append("},")

        lines.append("},")

        lines.append("}")
        return "\n".join(lines)


if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        print(f"Usage: python {sys.argv[0]} my_story.twee")
        sys.exit(1)

    path = sys.argv[1]
    story = parse_twee(path)

    conv = LuaConverter(story)
    entries, nodes = conv.convert()

    emitter = LuaEmitter(entries, nodes)
    s = emitter.emit()
    with open("test.lua", "w", encoding="utf-8") as f:
        f.write(s)

    # print("PASSAGES:")
    # for name, p in story.passages.items():
    #     print(f"  {name!r} tags={p.tags} links={len(p.links)}")
    #     for ln in p.links:
    #         print(f"    -> {ln.target!r} display={ln.display!r}")
