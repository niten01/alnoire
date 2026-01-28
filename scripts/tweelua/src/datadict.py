from dataclasses import dataclass
from typing import Dict
from src.errors import ParseError


@dataclass
class DataDict:
    type: str
    fields: Dict[str, any]


def parse_datadict(payload: str) -> DataDict:
    type_split = payload.split(":")
    if len(type_split) != 2:
        raise ParseError(f'Invalid DataDict syntax: "{payload}"')
    type, fields_raw = type_split
    fields = {}
    for kv_raw in fields_raw.split(","):
        kv_split = kv_raw.strip().split("=")
        if len(kv_split) == 1:
            key, value = type, kv_split[0]
        elif len(kv_split) == 2:
            key, value = kv_split
        else:
            raise ParseError(f'Invalid DataDict field key value pair: "{kv_raw}"')

        if not key or len(key) == 0:
            raise ParseError(f'Invalid DataDict field key in: "{kv_raw}"')
        fields[key] = value

    for k, v in fields.items():
        if v in ["true", "false"]:
            fields[k] = {"true": True, "false": False}[v]
        else:
            try:
                fields[k] = int(v)
            except ValueError:
                pass
    return DataDict(type, fields)
