#!/usr/bin/env python3
from pathlib import Path


def main():
    print("🔗 Linking Tmux config...")

    dotfiles_dir = Path(__file__).resolve().parent
    source = dotfiles_dir / ".tmux.conf"
    target = Path.home() / ".tmux.conf"

    if source.exists():
        if target.is_symlink() or target.exists():
            target.unlink()
        target.symlink_to(source)
        print("✅ Linked configuration: .tmux.conf")
    else:
        print("⚠️  No .tmux.conf found in dotfiles tmux directory.")
        print("   Skipping symlink.")


if __name__ == "__main__":
    main()
