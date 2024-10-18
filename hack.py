import os
import re
import glob
import argparse


def rename_in_file(file_path, old_pattern, new_pattern):
    with open(file_path, "r") as file:
        content = file.read()

    updated_content = re.sub(re.escape(old_pattern), new_pattern, content)

    if content != updated_content:
        with open(file_path, "w") as file:
            file.write(updated_content)
        print(f"Updated: {file_path}")
    else:
        print(f"No changes in: {file_path}")


def rename_in_directory(base_dir, patterns, old_pattern, new_pattern):
    print(f"Replacing {old_pattern} with {new_pattern}")
    for pattern in patterns:
        for file_path in glob.glob(os.path.join(base_dir, pattern)):
            rename_in_file(file_path, old_pattern, new_pattern)


def main():
    parser = argparse.ArgumentParser(description="Hack DP base URL")
    parser.add_argument("model_path", type=str, help="The model path, e.g., `llama3.2/3b-instruct-fp16-6cc3-lm`")
    args = parser.parse_args()

    base_directory = f"bentoml/bentos/{args.model_path}/src/ui"

    rename_in_directory(
        base_directory,
        [
            "chat.html",
            "src/ui/chat.html",
        ],
        old_pattern='"/chat/',
        new_pattern='"./chat/',
    )

    rename_in_directory(
        base_directory,
        [
            "_next/static/chunks/69-*.js",
            "_next/static/chunks/main-*.js",
            "_next/static/chunks/webpack-*.js",
        ],
        old_pattern='"/chat',
        new_pattern='"./chat',
    )

    rename_in_directory(
        base_directory,
        [
            "_next/static/chunks/app/chat/page-*.js",
        ],
        old_pattern='"/v1/models"',
        new_pattern='"./v1/models"',
    )
    rename_in_directory(
        base_directory,
        [
            "_next/static/chunks/app/chat/page-*.js",
        ],
        old_pattern='"/v1/chat/completions"',
        new_pattern='"./v1/chat/completions"',
    )


if __name__ == "__main__":
    main()
