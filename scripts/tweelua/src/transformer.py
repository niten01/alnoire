from src.errors import TransformError
from src.datatypes import *
from transliterate import translit
import re

ENTRY_TYPE_FIELD_PATTERNS = {
    "quest": ["questID"],
    "var": ["var", "value"],
    "bean": ["beat"],
    "trigger": ["trigger"],
}


class StoryTransformer:
    """
    Transforms story to fit target format requirements
    """

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

    def _detect_entry_condition_type(self, tag: DataDict) -> str:
        assert tag.type == "when"
        types = []
        for type, fields in ENTRY_TYPE_FIELD_PATTERNS.items():
            all_match = True
            for field in fields:
                if field not in tag.fields:
                    all_match = False
                    break
            if all_match:
                types.append(type)
        if len(types) == 0:
            raise TransformError(
                f"Unknown entry condition type. Tag with fields: {tag.fields}"
            )
        elif len(types) > 1:
            raise TransformError(
                f"Ambiguity in entry condition type resolution. Tag with fields: {fields}, matches: {types}"
            )
        return types[0]

    def _add_entries_from(self, passage: Passage):
        conditions = []
        for tag in passage.tags:
            if tag.type == "when":
                condition_type = self._detect_entry_condition_type(tag)
                conditions.append(DataDict(condition_type, tag.fields))
        if len(conditions) > 0:
            self.story.entries[passage.name] = conditions

    def _try_propagate_speaker(self, passage: Passage):
        if not passage.speaker:
            return

        for next in [self.story.passages[l.target] for l in passage.links]:
            if next.speaker:
                continue
            next.speaker = passage.speaker
            self._try_propagate_speaker(next)

    def _set_speaker(self, passage: Passage):
        speakers = [t for t in passage.tags if t.type == "speaker"]
        if len(speakers) > 1:
            raise TransformError(
                f'More than 1 speaker tag found in node: "{passage.name}"'
            )
        if len(speakers) != 0:
            passage.speaker = speakers[0]

    def transform(self) -> Story:
        for name in list(self.story.passages.keys()):
            node_id = self._gen_node_id(name)
            self.story.rename(name, node_id)

        for passage in self.story.passages.values():
            self._add_entries_from(passage)
            self._set_speaker(passage)

        for passage in self.story.passages.values():
            self._try_propagate_speaker(passage)

        return self.story
