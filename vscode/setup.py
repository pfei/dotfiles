#!/usr/bin/env python3
import subprocess
import shutil
from pathlib import Path


def main():
    print("🔧 Starting VS Code setup...")

    # 0. Global safety check: Is VS Code installed?
    if not shutil.which("code"):
        print("⚠️  VS Code binary ('code') not found in PATH.")
        print("   Skipping complete VS Code configuration.")
        return

    vscode_dir = Path(__file__).resolve().parent
    vscode_user_dir = Path.home() / ".config" / "Code" / "User"

    # Ensure the target configuration directory exists and is not a symlink
    if vscode_user_dir.is_symlink():
        vscode_user_dir.unlink()
    vscode_user_dir.mkdir(parents=True, exist_ok=True)

    # 1. Link JSON configuration files
    for filename in ["settings.json", "keybindings.json"]:
        source = vscode_dir / filename
        target = vscode_user_dir / filename

        if source.exists():
            if target.is_symlink() or target.exists():
                target.unlink()
            target.symlink_to(source)
            print(f"✅ Linked configuration: {filename}")

    # 2. Link snippets directory
    source_snippets = vscode_dir / "snippets"
    target_snippets = vscode_user_dir / "snippets"

    if source_snippets.is_dir():
        if target_snippets.is_symlink():
            target_snippets.unlink()
        elif target_snippets.exists():
            shutil.rmtree(target_snippets)

        target_snippets.symlink_to(source_snippets)
        print("✅ Snippets directory linked.")
    else:
        print("ℹ️  No snippets directory found in dotfiles VS Code directory.")
        print("   Skipping snippets configuration.")

    print("✅ Configuration files linked successfully.")

    # 3. Install extensions from extensions.txt
    extensions_file = vscode_dir / "extensions.txt"

    if extensions_file.is_file():
        print("📦 Installing extensions...")
        try:
            with open(extensions_file, "r", encoding="utf-8") as f:
                lines = f.readlines()

            for line in lines:
                line = line.strip()
                if not line or line.startswith("#"):
                    continue

                print(f"   Installing: {line}")
                subprocess.run(["code", "--install-extension", line], check=False)

            print("✅ Extensions installation process completed.")
        except Exception as e:
            print(f"❌ Error while reading extensions file: {e}")
    else:
        print("ℹ️  No extensions.txt found. Skipping installation.")

    print("🚀 VS Code setup finished!")


if __name__ == "__main__":
    main()
