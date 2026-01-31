from src.errors import TransformError
from src.datatypes import *
from transliterate import translit
import re

ENTRY_TYPE_FIELD_PATTERNS = {
    "quest": ["questID"],
    "var": ["var", "value"],
    "ent_var": ["ent_var", "value"],
    "visit": ["visited"],
    "beat": ["beat"],
    "trigger": ["trigger"],
    "interact": ["interact"],
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
        priority = 0
        for tag in passage.tags:
            if tag.type == "when":
                try:
                    condition_type = self._detect_entry_condition_type(tag)
                    conditions.append(DataDict(condition_type, tag.fields))
                except TransformError as e:
                    raise TransformError(
                        f'Failed to add entry from: "{passage.name}". Failed tag: {tag}\n->Exception:{e}'
                    )
            elif tag.type == "priority":
                priority = int(tag.fields["priority"])
        if len(conditions) > 0:
            self.story.entries[passage.name] = Entrypoint(priority, conditions)

    def _try_propagate_speaker(self, passage: Passage):
        if not passage.speaker:
            return

        for next in [self.story.passages[l.target] for l in passage.links]:
            if next.speaker:
                continue
            next.speaker = passage.speaker
            self._try_propagate_speaker(next)

    def _set_speaker(self, passage: Passage):
        speaker_tags = [t for t in passage.tags if t.type == "speaker"]
        if len(speaker_tags) > 1:
            raise TransformError(
                f'More than 1 speaker tag found in node: "{passage.name}"'
            )
        if len(speaker_tags) != 0:
            passage.speaker = speaker_tags[0].fields["speaker"]

    def _add_close_links(self):
        for _, passage in self.story.passages.items():
            if len(passage.links) == 0:
                passage.links.append(Link("", "Закрыть.", None, []))
                continue
            for link in passage.links:
                next = self.story.passages[link.target]
                if len(next.text.replace("\n", "").replace(" ", "")) == 0:
                    link.target = None

    def transform(self) -> Story:
        for name in list(self.story.passages.keys()):
            node_id = self._gen_node_id(name)
            self.story.rename(name, node_id)

        for passage in self.story.passages.values():
            self._add_entries_from(passage)
            self._set_speaker(passage)

        for passage in self.story.passages.values():
            self._try_propagate_speaker(passage)

        self._add_close_links()

        return self.story
