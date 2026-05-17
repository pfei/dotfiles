#!/usr/bin/env python3
import shutil
import subprocess
from pathlib import Path


def apply_mate_settings(dotfiles_themes_dir):
    print("⚙️  Applying MATE interface settings...")

    settings = [
        ("org.mate.interface", "gtk-theme", "Dracula"),
        ("org.mate.interface", "icon-theme", "Mint-Y"),
        ("org.mate.interface", "buttons-have-icons", "true"),
        ("org.mate.interface", "menus-have-icons", "true"),
        ("org.mate.interface", "toolbar-icons-size", "large-toolbar"),
        ("org.mate.Marco.general", "theme", "Dracula"),
    ]

    for schema, key, value in settings:
        subprocess.run(["gsettings", "set", schema, key, value], check=True)
    print("✅ MATE settings applied.")

    print("🖼️  Applying wallpaper settings...")
    wallpaper_path = dotfiles_themes_dir / "one-pixel-dracula.bmp"

    bg_settings = [
        ("picture-filename", str(wallpaper_path)),
        ("picture-options", "wallpaper"),
        ("color-shading-type", "solid"),
        ("draw-background", "true"),
        ("background-fade", "true"),
        ("picture-opacity", "100"),
        ("primary-color", "rgb(0,0,0)"),
        ("secondary-color", "rgb(98,127,90)"),
        ("show-desktop-icons", "true"),
    ]

    for key, value in bg_settings:
        subprocess.run(
            ["gsettings", "set", "org.mate.background", key, value], check=True
        )
    print("✅ Wallpaper settings applied.")


def main():
    script_dir = Path(__file__).resolve().parent
    gtk_themes_dir = Path.home() / ".themes"

    print("🔗 Linking GTK themes...")
    gtk_themes_dir.mkdir(parents=True, exist_ok=True)

    for item in script_dir.iterdir():
        # Skip the python script itself and other configuration files
        if item.is_dir():
            target_link = gtk_themes_dir / item.name

            # Robust cleanup before linking
            if target_link.is_symlink():
                target_link.unlink()
            elif target_link.is_dir():
                shutil.rmtree(target_link)  # Safely remove existing directory
            elif target_link.exists():
                target_link.unlink()  # Remove regular file if any

            target_link.symlink_to(item)
            print(f"✅ Linked theme: {item.name}")
    print("✅ Themes linked.")

    # Secure check for gsettings availability
    if shutil.which("gsettings"):
        apply_mate_settings(script_dir)
    else:
        print("⏭️  gsettings command not found. Skipping GUI settings configuration.")


if __name__ == "__main__":
    main()
