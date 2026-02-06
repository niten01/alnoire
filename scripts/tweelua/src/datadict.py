from dataclasses import dataclass
from typing import Dict
from src.errors import ParseError


@dataclass
class DataDict:
    type: str
    fields: Dict[str, any]


def parse_val(val: str) -> any:
    alt_split = str(val).split("/")
    if val in ["true", "false"]:
        return {"true": True, "false": False}[val]
    elif len(alt_split) > 1:
        return list(map(parse_val, alt_split))
    else:
        try:
            num = int(val)
            return num
        except ValueError:
            pass
    return val


def parse_datadict(payload: str) -> DataDict:
    type_split = payload.split(":")
    if len(type_split) != 2:
        raise ParseError(f'Invalid DataDict syntax: "{payload}"')
    type, fields_raw = type_split
    fields = {}
    if len(fields_raw.strip()) == 0:
        return DataDict(type, fields)
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
        fields[key] = parse_val(value)

    return DataDict(type, fields)
