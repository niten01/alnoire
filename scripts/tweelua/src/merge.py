from src.datatypes import *
from src.errors import MergeError
import copy


def merge(og: Story, s: Story) -> Story:
    for p in s.passages.values():
        for link in p.links:
            if link.target in og.passages:
                raise MergeError(
                    """Accidental link merge (new -> old): 
                    {p.name}
                    --{link.target}->
                    {og.passages[link.target]}"""
                )
    for p in og.passages.values():
        for link in p.links:
            if link.target in s.passages:
                raise MergeError(
                    """Accidental link merge (old -> new): 
                    {p.name}
                    --{link.target}->
                    {s.passages[link.target]}"""
                )

    for id, passage in s.passages.items():
        if id in og.passages:
            new_id = f"{id}_merged_{s.title}"
            if new_id in og.passages:
                raise MergeError(
                    f"Colliding passage ids found: {s.title}::{new_id} overrides {og.title}::{new_id}"
                )
            s.rename(id, new_id)
        og.passages[id] = passage

    for id, entrypoint in s.entries.items():
        if id in og.entries:
            raise MergeError(
                f"Colliding entrypoint ids found: {s.title}::{id} overrides {og.title}::{id}"
            )
        og.entries[id] = entrypoint

    print(
        f"Merged {og.title} with {s.title}: {len(og.passages)} passages with {sum(len(p.links) for p in og.passages.values())} links."
    )
    og.title = f"{og.title}+{s.title}"
    return og
