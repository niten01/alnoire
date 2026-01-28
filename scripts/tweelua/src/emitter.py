from src.datatypes import *


class LuaEmitter:
    def __init__(self, story: Story):
        self.story = story
        self.lines = []

    def _format_value(self, val) -> str:
        if type(val) is int:
            return str(val)
        elif type(val) is bool:
            return "true" if val else "false"
        return f'"{str(val)}"'

    def _datadict_to_dict(self, datadict: DataDict) -> dict:
        res = datadict.fields
        res["type"] = datadict.type
        return res

    def _emit_datadict_oneline(self, datadict: dict):
        d = self._datadict_to_dict(datadict)
        self.lines.append(
            f"{{ {','.join(k+'='+self._format_value(v) for k,v in d.items())} }},"
        )

    def _emit_choice_actions(self, actions):
        self.lines.append("actions = {")
        for action in actions:
            self._emit_datadict_oneline(action)
        self.lines.append("},")

    def _emit_one_node(self, id):
        node = self.story.get(id)
        self.lines.append(id + " = {")

        self.lines.append(f"text = [[{node.text}]],")
        if not node.speaker:
            print(f'warning: node "{node.name}" has no speaker, setting "default"')
        self.lines.append(f"speaker = [[{node.speaker or 'default'}]],")
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

    def _emit_entries(self):
        self.lines.append("entries = {")
        for node_id, conditions in self.story.entries.items():
            self.lines.append(f"{node_id} = {{")
            for condition in conditions:
                self._emit_datadict_oneline(condition)
            self.lines.append("},")
        self.lines.append("},")

    def emit(self):
        self.lines.append(
            """local QuestStatus = require('modules.quest.quest_status')"""
        )
        self.lines.append("return {")
        self._emit_entries()
        self._emit_nodes()
        self.lines.append("}")
        return self.lines
