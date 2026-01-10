import re
from pathlib import Path

HEADER_RE = re.compile(r"^::\s*(.+?)\s*$")
LINK_RE = re.compile(r"\[\[(.+?)\]\]")

def kv_escape(s: str) -> str:
    return s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n")

def parse_header(header_line: str):
    metadata = None
    m = re.search(r"\s*(\{.*\})\s*$", header_line)
    if m:
        metadata = m.group(1)
        header_line = header_line[:m.start()].rstrip()

    tags = []
    t = re.search(r"\s*(\[[^\]]*\])\s*$", header_line)
    if t:
        tags_block = t.group(1)[1:-1].strip()
        tags = tags_block.split() if tags_block else []
        header_line = header_line[:t.start()].rstrip()

    name = header_line.strip()
    return name, tags, metadata

def parse_link_target(raw: str):
    if "->" in raw:
        display, target = raw.split("->", 1)
        return display.strip(), target.strip()
    if "<-" in raw:
        target, display = raw.split("<-", 1)
        return display.strip(), target.strip()
    if "|" in raw:
        display, target = raw.split("|", 1)
        return display.strip(), target.strip()
    s = raw.strip()
    return s, s

def split_passages(twee_text: str):
    lines = twee_text.splitlines()
    passages = []
    cur = None

    def flush():
        nonlocal cur
        if cur:
            passages.append(cur)
            cur = None

    for line in lines:
        m = HEADER_RE.match(line)
        if m:
            flush()
            name, tags, metadata = parse_header(m.group(1))
            cur = {"name": name, "tags": tags, "metadata": metadata, "body": []}
        else:
            if cur is not None:
                cur["body"].append(line)

    flush()
    return passages

def extract_choices(body: str):
    choices = []
    for match in LINK_RE.finditer(body):
        display, target = parse_link_target(match.group(1))
        choices.append((display, target))
    return choices

def strip_links(body: str):
    return LINK_RE.sub("", body)

def to_kv(passages):
    out = []
    out.append('"Dialogues"\n{')
    for p in passages:
        name = p["name"]
        body = "\n".join(p["body"]).strip()
        if not name:
            continue

        choices = extract_choices(body)
        text = strip_links(body).strip()

        out.append(f'  "{kv_escape(name)}"\n  {{')
        if p["tags"]:
            out.append(f'    "tags" "{kv_escape(" ".join(p["tags"]))}"')
        if text:
            out.append(f'    "text" "{kv_escape(text)}"')

        out.append('    "choices"\n    {')
        for i, (c_text, c_next) in enumerate(choices, start=1):
            out.append(f'      "{i}"\n      {{')
            out.append(f'        "text" "{kv_escape(c_text)}"')
            out.append(f'        "next" "{kv_escape(c_next)}"')
            out.append('      }')
        out.append('    }')
        out.append('  }')
    out.append('}')
    return "\n".join(out)

def convert_file(src_path: str, dst_path: str):
    twee = Path(src_path).read_text(encoding="utf-8")
    passages = split_passages(twee)
    kv = to_kv(passages)
    Path(dst_path).write_text(kv, encoding="utf-8")

if __name__ == "__main__":
    convert_file("story.twee", "dialogues.kv")
