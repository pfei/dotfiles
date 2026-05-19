#!/usr/bin/env python3
from pathlib import Path


def main():
    print("🔗 Configuring Git...")

    git_dir = Path(__file__).resolve().parent
    gitconfig_local = git_dir / "gitconfig"
    global_gitconfig = Path.home() / ".gitconfig"

    if not gitconfig_local.exists():
        print("⚠️  No gitconfig found in repository git/ folder. Skipping.")
        return

    # Dynamically get the absolute path of the local gitconfig
    # This will work wherever the repository is cloned
    include_path = str(gitconfig_local.resolve())

    content = ""
    if global_gitconfig.exists():
        content = global_gitconfig.read_text(encoding="utf-8")

    # If the exact absolute path is already registered, we are good
    if f"path = {include_path}" in content:
        print("✅ Git include is already configured correctly.")
        return

    lines = content.splitlines()

    # Clean any old paths pointing to gitconfig (handles old ~/.dotfiles or other clones)
    cleaned_lines = [l for l in lines if "/git/gitconfig" not in l]

    # Insert the include section cleanly
    if "[include]" not in content:
        cleaned_lines.insert(0, "[include]")
        cleaned_lines.insert(1, f"    path = {include_path}")
    else:
        idx = cleaned_lines.index("[include]")
        cleaned_lines.insert(idx + 1, f"    path = {include_path}")

    global_gitconfig.write_text("\n".join(cleaned_lines) + "\n", encoding="utf-8")
    print(f"✅ Updated ~/.gitconfig with dynamic path: {include_path}")


if __name__ == "__main__":
    main()
