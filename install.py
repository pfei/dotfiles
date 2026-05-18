#!/usr/bin/env python3
import os
import subprocess
from pathlib import Path


def main():
    print("🏗️  Starting Global Dotfiles Installation (Python Edition)...")

    # Paths configuration
    dotfiles_dir = Path(__file__).resolve().parent
    home_dir = Path.home()

    # Detect headless environment (VPS / Server without GUI)
    is_headless = not (os.environ.get("DISPLAY") or os.environ.get("WAYLAND_DISPLAY"))

    # Order of modules to install
    configs = [
        "zsh",
        "tmux",
        "vscode",
        "helix",
        "vim",
        "pandoc",
        "themes",
        "mate-terminal",
    ]
    gui_only_modules = {"vscode", "themes", "mate-terminal"}

    for config in configs:
        if is_headless and config in gui_only_modules:
            print(f"⏭️  Headless environment: Skipping GUI module ({config})")
            continue

        py_setup = dotfiles_dir / config / "setup.py"

        if py_setup.exists():
            print(f"─── Installing {config} ───")
            subprocess.run(["python3", str(py_setup)], check=False)
        else:
            print(f"⚠️  No setup.py script found in {config}/")

    # Automate symlinks for user binaries/scripts (~/.local/bin)
    local_bin_dir = home_dir / ".local" / "bin"
    local_bin_dir.mkdir(parents=True, exist_ok=True)

    dotfiles_bin_dir = dotfiles_dir / ".local" / "bin"
    if dotfiles_bin_dir.is_dir():
        print("─── Linking User Binaries ───")
        for bin_file in dotfiles_bin_dir.iterdir():
            if bin_file.is_file():
                target_link = local_bin_dir / bin_file.name

                if target_link.is_symlink() or target_link.exists():
                    target_link.unlink()

                target_link.symlink_to(bin_file)
                print(f"✅ Linked binary: {bin_file.name}")

    print("🎉 Installation complete!")


if __name__ == "__main__":
    main()
