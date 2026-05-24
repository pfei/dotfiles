#!/usr/bin/env python3
import os
from pathlib import Path


def setup_gitconfig():
    """
    Creates or updates the global ~/.gitconfig to include the dotfiles gitconfig.
    This acts as the entry point for the entire Git configuration.
    """
    global_config = Path.home() / ".gitconfig"
    dotfiles_dir = Path(__file__).resolve().parent
    dotfiles_gitconfig = dotfiles_dir / "gitconfig"

    # Standard content for the global entry point
    expected_content = f"[include]\n    path = {dotfiles_gitconfig}\n"

    if (
        global_config.exists()
        and global_config.read_text(encoding="utf-8") == expected_content
    ):
        print("✅ ~/.gitconfig is already correctly configured.")
        return

    global_config.write_text(expected_content, encoding="utf-8")
    print(f"✅ Updated ~/.gitconfig to include: {dotfiles_gitconfig}")


def setup_headless_optimization():
    """
    Optimizes headless environments by enabling the credential store helper.
    Only applied if no display server (X11/Wayland) is detected.
    """
    # Check for headless environment
    is_headless = not (os.environ.get("DISPLAY") or os.environ.get("WAYLAND_DISPLAY"))

    if not is_headless:
        return

    global_config = Path.home() / ".gitconfig"
    if not global_config.exists():
        return

    content = global_config.read_text(encoding="utf-8")

    if "[credential]" in content:
        print("✅ Credential helper already configured or handled elsewhere.")
        return

    # Append headless credential helper to the end of ~/.gitconfig
    with open(global_config, "a", encoding="utf-8") as f:
        f.write("\n[credential]\n    helper = store\n")
    print("🖥️  Headless environment detected: Configured credential.helper to store.")


def main():
    print("🔗 Initializing global Git configuration...")
    setup_gitconfig()
    setup_headless_optimization()


if __name__ == "__main__":
    main()
