import re
from typing import List, Dict
from src.datatypes import *
from src.errors import ParseError
from src.datadict import DataDict, parse_datadict
from pytwee.story import Story as PytweeStory
from pytwee.twee3 import Parser as PytweeParser

LINK_RE = re.compile(
    r"\[\[(?:(?P<display>.*?)(?:->|\|))?(?P<target>.*?)\]\](?:\((?P<actions>.*?)\))?"
)


def _parse_actions(raw: str) -> List[DataDict]:
    result = []
    objs = [b.strip() for b in raw.split("|")]
    for obj in objs:
        try:
            action = parse_datadict(obj)
        except ParseError as e:
            raise ParseError(f'Failed to parse action from: "{raw}"\n->Exception: {e}')
        result.append(action)
    return result


def _parse_links(text: str) -> tuple[str, List[Link]]:
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
            if len(target.strip()) == 0:
                raise ParseError(f"Empty link target: {text}")
            actions_raw = m.group("actions") or None
            actions = []
            if actions_raw:
                try:
                    actions = _parse_actions(actions_raw)
                except ParseError as e:
                    raise ParseError(
                        f'Failed to parse links from passage text: "{text}"\n->Exception: {e}'
                    )
            links.append(
                Link(raw=raw, display=display, target=target.strip(), actions=actions)
            )

        else:
            text_content += line
    return text_content, links


def parse_twee(filepath: str) -> Story:
    story = Story()
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
        text, links = _parse_links(raw)
        num_links += len(links)
        text = text.replace("\n", "\\n")
        tags = []
        for tag in p.header.tags or []:
            try:
                tag_dd = parse_datadict(tag)
                tags.append(tag_dd)
            except ParseError:
                pass
        passage = Passage(name=p.header.name, tags=tags or [], text=text, links=links)
        story.add(passage)

    print(f"Parsed {len(story.passages)} passages with {num_links} links.")
    return story
