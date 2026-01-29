from dataclasses import dataclass, field
from typing import List, Dict
from enum import Enum
from src.datadict import DataDict


@dataclass
class Link:
    raw: str
    display: str
    target: str | None
    actions: List[DataDict]


@dataclass
class Passage:
    name: str
    tags: List[DataDict]
    text: str = ""
    links: List[Link] = field(default_factory=list)
    speaker: str | None = field(default=None)

    def __repr__(self) -> str:
        return (
            f"<Passage name={self.name!r} tags={self.tags!r} links={len(self.links)}>"
        )


@dataclass
class Entrypoint:
    priority: int
    conditions: List[DataDict]


@dataclass
class Story:
    title: str | None = None
    passages: Dict[str, Passage] = field(default_factory=dict)
    entries: Dict[str, List[Entrypoint]] = field(default_factory=dict)

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
