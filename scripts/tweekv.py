import re
from dataclasses import dataclass, field
from typing import List, Dict
from enum import Enum

import pytwee
from pytwee.story import Story as PytweeStory
from pytwee.twee3 import Parser as PytweeParser
from transliterate import translit

##################################################################################


@dataclass
class Link:
    raw: str
    display: str
    target: str
    actions: List[Dict] | None = field(default=None)


@dataclass
class Passage:
    name: str
    tags: List[str] = field(default_factory=list)
    text: str = ""
    links: List[Link] = field(default_factory=list)

    def __repr__(self) -> str:
        return (
            f"<Passage name={self.name!r} tags={self.tags!r} links={len(self.links)}>"
        )


class QuestStatusLua(Enum):
    ACTIVE = "QuestStatus.ACTIVE"
    INACTIVE = "QuestStatus.INACTIVE"
    REJECTED = "QuestStatus.REJECTED"
    COMPLETED = "QuestStatus.COMPLETED"


@dataclass
class EntryQuestCondition:
    status: QuestStatusLua
    start_node: str
    step_num: int | None


@dataclass
class Entrypoint:
    quest_conditions: Dict[str, EntryQuestCondition]


@dataclass
class Story:
    title: str | None = None
    passages: Dict[str, Passage] = field(default_factory=dict)
    entries = Dict[str, Entrypoint]

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


LINK_RE = re.compile(
    r"\[\[(?:(?P<display>.*?)(?:->|\|))?(?P<target>.*?)\]\](?:\((?P<actions>.*?)\))?"
)


def parse_actions(payload: str) -> List:
    result = []
    command_blocks = [c.strip() for c in payload.split("|")]
    for block in command_blocks:
        action_type, action_args = block.split(":")
        action = {
            kv.split("=")[0].strip(): kv.split("=")[1].strip()
            for kv in action_args.split(",")
        }
        action["type"] = action_type
        for k, v in action.items():
            try:
                action[k] = int(v)
            except ValueError:
                pass
        result.append(action)
    return result


def extract_links(text: str) -> tuple[str, List[Link]]:
    links: List[Link] = []
    text_content = ""
    for line in text.split("\n"):
        if len(line) == 0 or line == "\n":
            continue
        m = LINK_RE.match(line)
        if m:
            raw = m.group(0)
            target = m.group("target")
            display = m.group("display") or target
            actions = m.group("actions") or None
            if actions:
                actions = parse_actions(actions)
            links.append(
                Link(raw=raw, display=display, target=target.strip(), actions=actions)
            )

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
            name=p.header.name, tags=p.header.tags or [], text=text, links=links
        )
        story.add(passage)

    print(f"Parsed {len(story.passages)} passages with {num_links} links.")
    return story


#####################################################################################


class LuaConverter:
    def __init__(self, story: Story):
        self.story = story
        self.node_id_counter: dict[str, int] = {}

    def _gen_node_id(self, name):
        node_id: str = translit(name, language_code="ru", reversed=True)
        node_id = re.sub(r"\s+", "_", re.sub(r"[^a-z\s\d]", "", node_id.lower()))
        node_id = node_id.strip("_")
        node_id = node_id.replace("ja", "ya").replace("ju", "u")
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

        return self.story


class LuaEmitter:
    def __init__(self, story: Story):
        self.story = story
        self.lines = []

    def _format_value(self, val) -> str:
        if type(val) is int:
            return val
        return f'"{val}"'

    def _emit_flat_dict_oneline(self, dict):
        self.lines.append(
            f"{{ {','.join(k+'='+self._format_value(v) for k,v in dict.items())} }},"
        )

    def _emit_choice_actions(self, actions):
        self.lines.append("actions = {")
        for action in actions:
            self._emit_flat_dict_oneline(action)
        self.lines.append("},")

    def _emit_one_node(self, id):
        node = self.story.get(id)
        self.lines.append(id + " = {")

        self.lines.append(f"text = [[{node.text}]],")
        self.lines.append("choices = {")
        for link in node.links:
            self.lines.append("{")
            self.lines.append(f"text = [[{link.display}]],")
            self.lines.append(f'next = "{link.target}",')
            if link.actions:
                self._emit_choice_actions(link.actions)
            self.lines.append("},")
        self.lines.append("},")

        self.lines.append("},")

    def _emit_nodes(self):
        self.lines.append("nodes = {")
        for id in self.story.passages.keys():
            self._emit_one_node(id)
        self.lines.append("},")

    def emit(self):
        self.lines.append(
            """local QuestStatus = require('modules.quest.quest_status')"""
        )
        self.lines.append("return {")
        self._emit_nodes()
        self.lines.append("}")
        return self.lines


if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        print(f"Usage: python {sys.argv[0]} my_story.twee")
        sys.exit(1)

    path = sys.argv[1]
    story = parse_twee(path)

    conv = LuaConverter(story)
    story = conv.convert()

    emitter = LuaEmitter(story)
    lines = "\n".join(emitter.emit())
    with open("test.lua", "w", encoding="utf-8") as f:
        f.write(lines)
