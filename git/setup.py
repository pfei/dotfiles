#!/usr/bin/env python3
import os
from pathlib import Path


def main():
    print("🔗 Configuring Git...")

    git_dir = Path(__file__).resolve().parent
    gitconfig_local = git_dir / "gitconfig"
    global_gitconfig = Path.home() / ".gitconfig"

    if not gitconfig_local.exists():
        print("⚠️  No gitconfig found in repository git/ folder. Skipping.")
        return

    # Detect headless environment
    is_headless = not (os.environ.get("DISPLAY") or os.environ.get("WAYLAND_DISPLAY"))

    # Dynamically get the absolute path of the local gitconfig
    include_path = str(gitconfig_local.resolve())

    content = ""
    if global_gitconfig.exists():
        content = global_gitconfig.read_text(encoding="utf-8")

    # If the exact absolute path is already registered, we are good
    if f"path = {include_path}" in content:
        print("✅ Git include is already configured correctly.")
    else:
        lines = content.splitlines()

        # Clean any old paths pointing to gitconfig
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

    # Headless optimization only (no private data leaked)
    if is_headless and "[credential]" not in content:
        with open(global_gitconfig, "a", encoding="utf-8") as f:
            f.write("\n[credential]\n    helper = store\n")
        print("🖥️  Headless environment: Configured credential.helper to store locally.")


if __name__ == "__main__":
    main()
