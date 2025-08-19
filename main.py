import subprocess
from os.path import join
from pathlib import Path
from typing import Literal


def convert_file(target_extension: Literal["pdf", "xlsx"], file_path: str, result_dir: str) -> None:
    proc = subprocess.run(
        [
            "libreoffice",
            "--headless",
            "--nologo",
            "--nofirststartwizard",
            "--convert-to", target_extension,
            "--outdir", result_dir,
            file_path,
        ],
        check=True,
        timeout=300,
        capture_output=True,
    )

    if proc.stdout:
        print(f"Conversion output: {proc.stdout.decode()}")

    if proc.stderr:
        print(f"Conversion error: {proc.stderr.decode()}")
        return None

    result_path = join(result_dir, f"{Path(file_path).stem}.{target_extension}")
    print(f"File converted successfully to {result_path}")
    return None


def main():
    target_extension = "pdf"
    file_path = "/app/data/test.docx"
    result_dir = "/app/result"
    convert_file(target_extension, file_path, result_dir)

if __name__ == "__main__":
    main()
