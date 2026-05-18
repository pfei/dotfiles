#!/usr/bin/env python3
from pathlib import Path


def main():
    print("🔗 Linking Vim config...")

    dotfiles_dir = Path(__file__).resolve().parent
    source = dotfiles_dir / ".vimrc"
    target = Path.home() / ".vimrc"

    if source.exists():
        if target.is_symlink() or target.exists():
            target.unlink()
        target.symlink_to(source)
        print("✅ Linked configuration: .vimrc")
    else:
        print("⚠️  No .vimrc found in dotfiles vim directory.")
        print("   Skipping symlink.")


if __name__ == "__main__":
    main()
