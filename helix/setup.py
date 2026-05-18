#!/usr/bin/env python3
import os
import shutil
from pathlib import Path


def main():
    print("🔗 Configuring Helix...")

    dotfiles_dir = Path(__file__).resolve().parent
    helix_config_dir = Path.home() / ".config" / "helix"

    # 1. Handle idempotency for the config directory itself
    if helix_config_dir.is_symlink():
        # If it's a symlink pointing to dotfiles, we safely remove the link, NOT the files
        helix_config_dir.unlink()
    elif helix_config_dir.exists() and not helix_config_dir.is_dir():
        # Safety check: if it's a file for some reason, remove it
        helix_config_dir.unlink()

    # Now we can safely create a real directory
    helix_config_dir.mkdir(parents=True, exist_ok=True)

    # 2. Link configuration files (config.toml, languages.toml)
    for filename in ["config.toml", "languages.toml"]:
        source = dotfiles_dir / filename
        target = helix_config_dir / filename

        if source.exists():
            # If the source itself became a broken symlink, skip or handle it
            if source.is_symlink():
                continue

            if target.is_symlink() or target.exists():
                target.unlink()
            target.symlink_to(source)
            print(f"✅ Linked configuration: {filename}")

    # 3. Handle Helix Binary / AppImage symlink
    local_bin_dir = Path.home() / ".local" / "bin"
    hx_target = local_bin_dir / "hx"

    appimages = list(local_bin_dir.glob("helix-*-x86_64.AppImage"))

    if appimages:
        target_appimage = sorted(appimages)[-1]

        if hx_target.is_symlink() or hx_target.exists():
            if hx_target.is_file() and not hx_target.is_symlink():
                print(
                    f"⚠️  Warning: {hx_target} is a real file. Skipping symlink creation."
                )
                return
            hx_target.unlink()

        hx_target.symlink_to(target_appimage)
        print(f"✅ Helix symlinked: {target_appimage.name} → hx")
    else:
        if shutil.which("hx") or hx_target.exists():
            print("✅ Helix binary (hx) is already present.")
        else:
            print("⚠️  No Helix AppImage found in ~/.local/bin. Skipping hx symlink.")


if __name__ == "__main__":
    main()
