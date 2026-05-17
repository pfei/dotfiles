#!/usr/bin/env python3
import shutil
import subprocess
from pathlib import Path


def apply_terminal_profile(script_dir):
    dconf_profile_dir = "/org/mate/terminal/profiles/"
    dconf_file = script_dir / "catppucin.dconf"

    if dconf_file.exists():
        print("🎨 Loading Catppuccin profiles into dconf...")
        # Reset old profiles
        subprocess.run(["dconf", "reset", "-f", dconf_profile_dir], check=True)

        # Load the pack
        with open(dconf_file, "r") as f:
            subprocess.run(["dconf", "load", dconf_profile_dir], stdin=f, check=True)

        # Global system settings for MATE terminal
        subprocess.run(
            [
                "gsettings",
                "set",
                "org.mate.terminal.global",
                "default-profile",
                "Catppuccin-mocha",
            ],
            check=True,
        )
        subprocess.run(
            [
                "gsettings",
                "set",
                "org.mate.terminal.global",
                "profile-list",
                "['Catppuccin-mocha', 'default']",
            ],
            check=True,
        )
        print("✅ Catppuccin terminal profiles applied successfully.")
    else:
        print(f"⚠️  Error: catppucin.dconf not found in {script_dir}")


def main():
    script_dir = Path(__file__).resolve().parent

    if shutil.which("dconf") and shutil.which("gsettings"):
        apply_terminal_profile(script_dir)
    else:
        print("⏭️  dconf or gsettings missing. Skipping MATE Terminal configuration.")


if __name__ == "__main__":
    main()
