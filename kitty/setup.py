#!/usr/bin/env python3
from pathlib import Path


def main():
    print("🔗 Configuring Kitty...")

    dotfiles_dir = Path(__file__).resolve().parent
    source = dotfiles_dir / "kitty.conf"
    target = Path.home() / ".config" / "kitty" / "kitty.conf"

    target.parent.mkdir(parents=True, exist_ok=True)

    if source.exists():
        if target.is_symlink() or target.exists():
            target.unlink()

        target.symlink_to(source)
        print("✅ Linked configuration: kitty.conf")
    else:
        print("⚠️  No kitty.conf found in dotfiles kitty directory.")


if __name__ == "__main__":
    main()
