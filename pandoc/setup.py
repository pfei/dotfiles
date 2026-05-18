#!/usr/bin/env python3
from pathlib import Path


def main():
    print("🔗 Linking Pandoc templates...")

    dotfiles_dir = Path(__file__).resolve().parent
    templates_source_dir = dotfiles_dir / "templates"
    target_dir = Path.home() / ".local" / "share" / "pandoc" / "templates"

    # Ensure the target directory is a real directory
    if target_dir.is_symlink():
        target_dir.unlink()
    target_dir.mkdir(parents=True, exist_ok=True)

    # Find and link all .latex templates dynamically
    templates = list(templates_source_dir.glob("*.latex"))

    if templates:
        for source in templates:
            target = target_dir / source.name

            if target.is_symlink() or target.exists():
                target.unlink()
            target.symlink_to(source)
            print(f"✅ Linked template: {source.name}")
    else:
        print("⚠️  No .latex templates found in dotfiles pandoc directory.")
        print("   Skipping templates configuration.")


if __name__ == "__main__":
    main()
