#!/usr/bin/env python3
"""把编译 main.tex 所需的源文件打成 zip。"""

import argparse
import sys
import zipfile
from pathlib import Path


SOURCE_GLOBS = ("*.cls", "*.sty", "*.bib", "*.bst", "main.tex")
PROJECT_FILES = (".vscode/settings.json",)
FIGURES_DIRNAME = "figures"
FIGURES_SKIP = {"preview"}
DEFAULT_ARCHIVE = "ucas-homework-src.zip"


def collect_sources(root):
    """收集编译所需文件。

    Parameters
    ----------
    root : Path
        含 main.tex 与 homework.cls 的目录。

    Returns
    -------
    list of Path
        相对于 root 的文件路径，按路径排序。
    """
    selected = []
    for pattern in SOURCE_GLOBS:
        selected.extend(path for path in root.glob(pattern) if path.is_file())

    for relative in PROJECT_FILES:
        path = root / relative
        if path.is_file():
            selected.append(path)

    figures_dir = root / FIGURES_DIRNAME
    if figures_dir.is_dir():
        for path in figures_dir.rglob("*"):
            if not path.is_file():
                continue
            relative = path.relative_to(figures_dir)
            if relative.parts and relative.parts[0] in FIGURES_SKIP:
                continue
            selected.append(path)

    unique = sorted({path.resolve() for path in selected})
    return [path.relative_to(root.resolve()) for path in unique]


def write_archive(root, archive_path, relative_paths):
    """把相对路径列表写入 zip，目录结构与 root 一致。

    Parameters
    ----------
    root : Path
        源文件所在目录。
    archive_path : Path
        输出 zip 的路径。
    relative_paths : list of Path
        要写入的相对路径。
    """
    archive_path.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(
        archive_path, "w", compression=zipfile.ZIP_DEFLATED
    ) as archive:
        for relative in relative_paths:
            archive.write(root / relative, relative.as_posix())


def parse_args(argv):
    """解析命令行参数。

    Parameters
    ----------
    argv : list of str
        不含程序名的参数列表。

    Returns
    -------
    argparse.Namespace
        含 root 与 output 的解析结果。
    """
    parser = argparse.ArgumentParser(
        description="打包 main.tex、VS Code 编译配置、cls/sty/bib 与 figures 中的编译资源。"
    )
    parser.add_argument(
        "--root",
        type=Path,
        default=Path(__file__).resolve().parent,
        help="模板目录，默认是脚本所在目录",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=None,
        help="zip 输出路径，默认写到模板目录下的 %s" % DEFAULT_ARCHIVE,
    )
    return parser.parse_args(argv)


def main(argv=None):
    """收集源文件并写出 zip。

    Parameters
    ----------
    argv : list of str or None
        命令行参数；None 时读取 sys.argv。

    Returns
    -------
    int
        0 表示成功，1 表示缺少 main.tex 或没有可打包文件。
    """
    args = parse_args(sys.argv[1:] if argv is None else argv)
    root = args.root.resolve()
    archive_path = (
        args.output if args.output is not None else root / DEFAULT_ARCHIVE
    )
    archive_path = archive_path.resolve()

    if not (root / "main.tex").is_file():
        print("缺少 main.tex: %s" % root, file=sys.stderr)
        return 1

    relative_paths = [
        path
        for path in collect_sources(root)
        if (root / path).resolve() != archive_path
    ]
    if not relative_paths:
        print("没有可打包的文件", file=sys.stderr)
        return 1

    write_archive(root, archive_path, relative_paths)
    print(archive_path)
    for relative in relative_paths:
        print(relative.as_posix())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
