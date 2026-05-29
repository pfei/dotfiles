#!/usr/bin/env python3
from pathlib import Path


def main():
    print("🔗 Configuring Kitty...")

    dotfiles_dir = Path(__file__).resolve().parent
    target_dir = Path.home() / ".config" / "kitty"

    target_dir.mkdir(parents=True, exist_ok=True)

    config_files = ["kitty.conf", "dracula.conf"]

    for file_name in config_files:
        source = dotfiles_dir / file_name
        target = target_dir / file_name

        if source.exists():
            if target.is_symlink() or target.exists():
                target.unlink()

            target.symlink_to(source)
            print(f"✅ Linked configuration: {file_name}")
        else:
            print(f"⚠️  No {file_name} found in dotfiles kitty directory.")


if __name__ == "__main__":
    main()
