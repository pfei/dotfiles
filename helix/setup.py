#!/usr/bin/env python3
import shutil
from pathlib import Path


def main():
    print("🔗 Configuring Helix...")

    dotfiles_dir = Path(__file__).resolve().parent
    helix_config_dir = Path.home() / ".config" / "helix"

    # 1. Ensure config directory exists
    helix_config_dir.mkdir(parents=True, exist_ok=True)

    # 2. Link configuration files (config.toml, languages.toml)
    for filename in ["config.toml", "languages.toml"]:
        source = dotfiles_dir / filename
        target = helix_config_dir / filename

        if source.exists():
            if target.is_symlink() or target.exists():
                target.unlink()
            target.symlink_to(source)
            print(f"✅ Linked configuration: {filename}")

    # 3. Handle Helix Binary / AppImage symlink
    local_bin_dir = Path.home() / ".local" / "bin"
    hx_target = local_bin_dir / "hx"

    # Find any helix AppImage in ~/.local/bin
    appimages = list(local_bin_dir.glob("helix-*-x86_64.AppImage"))

    if appimages:
        # Sort to automatically take the highest version found
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
