#!/usr/bin/env python

import argparse
import os
import shutil
import tempfile
from pathlib import Path
from subprocess import call

project_home = Path(os.getenv("EM_CORE_HOME"))
product_home = Path(os.getenv("PRODUCT_HOME"))

patches_path = project_home / "patches"


def main():
    parser = argparse.ArgumentParser(
        prog="Create patches",
        description="Creates EM patches from files",
    )
    parser.add_argument("patch_name", help="It will be use to create the file")
    parser.add_argument(
        "patched_logical_path",
        help="For example 'AddKnowContentFeedback.Implementation.ContentFeeback.Verbs.InlineCreate.initialise'",
    )
    parser.add_argument(
        "product_version",
        help="For example '9.1.8'",
    )
    args = parser.parse_args()
    patch_name = args.patch_name
    patched_logical_path = args.patched_logical_path
    patched_file_str = patched_logical_path.replace(".", os.sep) + ".xml"
    patched_path = Path(patched_file_str)
    product_version = args.product_version

    patched_relative_path = Path("repository/default") / patched_path
    patched_abs_path_src = product_home / patched_relative_path

    patch_folder = patches_path / patch_name
    if patch_folder.exists():
        override = input(
            f"'{patch_folder}' already exist, do you want to override it?(y/n) "
        )
        if override == "y":
            shutil.rmtree(patch_folder)

    patch_folder.mkdir()
    meta_folder = patch_folder / "META-INF"
    meta_folder.mkdir()
    patch_index = meta_folder / "patch.index"
    patch_index.write_text(patch_name)
    (meta_folder / "product.version").write_text(product_version)

    patch_abs_path_dst = patch_folder / "core" / patched_relative_path
    patch_abs_path_dst.parent.mkdir(parents=True)
    shutil.copyfile(patched_abs_path_src, patch_abs_path_dst)

    readme_path = patch_folder / "README.md"
    readme_path.write_text(capture_readme_on_editor(patch_name))

    zip_file_path = patches_path / patch_name

    if zip_file_path.exists():
        zip_file_path.unlink()

    shutil.make_archive(zip_file_path, "zip", patch_folder)

    print(f"Patch folder created under {patch_folder}, remove before commit")
    print(f"Patch zip created under {zip_file_path}")


def capture_readme_on_editor(patch_name):
    EDITOR = os.environ.get("EDITOR", "vim")  # that easy!

    initial_message = (
        b"# " + patch_name.encode() + b"\n"
    )  # if you want to set up the file somehow

    with tempfile.NamedTemporaryFile(suffix=".md") as tf:
        tf.write(initial_message)
        tf.flush()
        call([EDITOR, tf.name])

        # do the parsing with `tf` using regular File operations.
        # for instance:
        tf.seek(0)
        bytes_msg = tf.read()
        return bytes_msg.decode("utf-8")
    return ""


if __name__ == "__main__":
    main()
