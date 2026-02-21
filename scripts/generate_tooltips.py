import os
import re
from dataclasses import dataclass
import time
import subprocess
import requests
import sys
from pathlib import Path
from multiprocessing import cpu_count
from tqdm import tqdm
from tqdm.contrib.concurrent import thread_map

SOURCE_LANG = "ru"
TARGET_LANG = "en"
PORT = 5000
URL = f"http://localhost:{PORT}"
FILE_EXTENSION = "*.txt"
WORKERS = cpu_count() * 2

LINE_PATTERN = re.compile(r"^(\s*\"[^\"]+\"\s+)\"([^\"]*\"[^\"]*\")(\s*(?://.*)?)$")


@dataclass
class Token:
    token: str
    localization: str
    file: Path


def wait_for_server(timeout=60):
    start_time = time.time()
    print(f"Waiting for LibreTranslate to start on port {PORT}...")
    while time.time() - start_time < timeout:
        try:
            response = requests.get(f"{URL}/health")
            if response.status_code == 200:
                print("Server is up and healthy!")
                return True
        except requests.ConnectionError:
            pass
        time.sleep(2)
    return False


def translate_token(token: Token):
    if len(token.localization) == 0:
        return token
    while True:
        response = requests.post(
            f"{URL}/translate",
            json={
                "q": token.localization,
                "source": SOURCE_LANG,
                "target": TARGET_LANG,
                "format": "text",
            },
        )
        resp_json = response.json()
        if "translatedText" not in resp_json:
            continue

        return Token(
            token.token,
            resp_json.get("translatedText"),
            token.file,
        )


def write_localization_file(file_path: Path, tokens: list[Token]):
    lang = file_path.stem.split("_")[1].capitalize()

    lines = (
        [
            "// This file is generated automatically from russian localization dir. Do not edit it directly!\n",
            '"lang"',
            "{",
            f'\t"Language" "{lang}"',
            '\t"Tokens"',
            "\t{",
        ]
        + list(map(lambda t: f'\t\t"{t.token}" "{t.localization}"', tokens))
        + ["\t}", "}"]
    )
    with open(file_path, "w", encoding="utf-16") as f:
        f.write("\n".join(lines))


def parse_line(line: str) -> tuple[str, str]:
    token = ""
    value = ""
    fst = line.find('"')
    snd = line.find('"', fst + 1)
    thrd = line.find('"', snd + 1)
    last = line.rfind('"')
    token = line[fst + 1 : snd]
    value = line[thrd + 1 : last]
    return token, value


def process_files(base_dir: Path):
    files = list(base_dir.rglob(FILE_EXTENSION))
    if not files:
        print("No files found.")
        return

    rus_tokens = []
    for file_path in tqdm(files, desc="Loading Files", unit="file"):
        with open(file_path, "r", encoding="utf-8") as f:
            lines = f.readlines()
            for line in lines:
                if line.count('"') < 4:
                    continue
                token, value = parse_line(line)
                rus_tokens.append(Token(token, value, file_path))

    # meta_lines = [
    #     "",
    #     f"\t\t// Generated from {os.path.relpath(file_path, base_dir)}",
    # ]
    # eng_tokens = thread_map(
    #     translate_token,
    #     rus_tokens,
    #     max_workers=WORKERS,
    #     desc=f"Translating tokens",
    #     unit="token",
    # )
    # write_localization_file(base_dir.parent / "addon_english.txt", eng_tokens)
    write_localization_file(base_dir.parent / "addon_russian.txt", rus_tokens)
    # TODO: remove in release
    write_localization_file(base_dir.parent / "addon_english.txt", rus_tokens)


if __name__ == "__main__":
    server_process = None
    base_dir = (
        Path(os.path.abspath(sys.argv[0])).parent.parent / "game/resource/russian"
    )
    try:
        # cmd = [
        #     "libretranslate",
        #     "--port",
        #     str(PORT),
        #     "--load-only",
        #     f"{SOURCE_LANG},{TARGET_LANG}",
        #     "--translation-cache",
        #     "all",
        #     "--threads",
        #     str(cpu_count()),
        # ]
        # server_process = subprocess.Popen(
        #     cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
        # )

        # if wait_for_server():
        process_files(base_dir)
    # else:
    #     print("Error: Server timed out.")

    except KeyboardInterrupt:
        print("\nStopping script...")
    finally:
        if server_process:
            print("Shutting down LibreTranslate...")
            server_process.terminate()
            server_process.wait()
            print("Done.")
