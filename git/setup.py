#!/usr/bin/env python3
import json
import os
from pathlib import Path


def setup_include(gitconfig_local: Path, global_gitconfig: Path) -> str:
    """Ensure ~/.gitconfig includes the repo gitconfig. Returns current file content."""
    include_path = str(gitconfig_local.resolve())

    content = ""
    if global_gitconfig.exists():
        content = global_gitconfig.read_text(encoding="utf-8")

    if f"path = {include_path}" in content:
        print("✅ Git include is already configured correctly.")
        return content

    lines = content.splitlines()
    cleaned_lines = [l for l in lines if "/git/gitconfig" not in l]

    if "[include]" not in content:
        cleaned_lines.insert(0, "[include]")
        cleaned_lines.insert(1, f"    path = {include_path}")
    else:
        idx = cleaned_lines.index("[include]")
        cleaned_lines.insert(idx + 1, f"    path = {include_path}")

    new_content = "\n".join(cleaned_lines) + "\n"
    global_gitconfig.write_text(new_content, encoding="utf-8")
    print(f"✅ Updated ~/.gitconfig with dynamic path: {include_path}")
    return new_content


def setup_identity(global_gitconfig: Path, identity: dict) -> None:
    """Inject name, email, signingkey into ~/.gitconfig."""
    content = (
        global_gitconfig.read_text(encoding="utf-8")
        if global_gitconfig.exists()
        else ""
    )

    def set_config(key: str, value: str) -> None:
        import subprocess

        subprocess.run(["git", "config", "--global", key, value], check=True)

    set_config("user.name", identity["name"])
    set_config("user.email", identity["email"])
    set_config("user.signingkey", identity["signingkey"])
    print("✅ Git identity configured (name, email, signingkey).")


def setup_allowed_signers(email: str, signingkey: str) -> None:
    """Append the local public key to ~/.ssh/allowed_signers if not already present."""
    ssh_dir = Path.home() / ".ssh"
    pubkey_path = Path(signingkey.replace("~", str(Path.home())))
    allowed_signers = ssh_dir / "allowed_signers"

    if not pubkey_path.exists():
        print(
            f"⚠️  No public key found at {pubkey_path}. Skipping allowed_signers setup."
        )
        print('   Generate a key with: ssh-keygen -t ed25519 -C "your@email.com"')
        return

    pubkey = pubkey_path.read_text(encoding="utf-8").strip()
    entry = f"{email} {pubkey}\n"

    existing = (
        allowed_signers.read_text(encoding="utf-8") if allowed_signers.exists() else ""
    )
    if entry in existing:
        print("✅ allowed_signers already up to date.")
        return

    with open(allowed_signers, "a", encoding="utf-8") as f:
        f.write(entry)
    print("✅ Added public key to ~/.ssh/allowed_signers")
    print("   Don't forget to add this key to GitHub → Settings → SSH keys (signing).")


def main():
    print("🔗 Configuring Git...")

    git_dir = Path(__file__).resolve().parent
    gitconfig_local = git_dir / "gitconfig"
    global_gitconfig = Path.home() / ".gitconfig"

    if not gitconfig_local.exists():
        print("⚠️  No gitconfig found in repository git/ folder. Skipping.")
        return

    # Load identity
    identity_file = git_dir / "identity.json"
    if not identity_file.exists():
        print("⚠️  git/identity.json not found.")
        print(
            "   Copy git/identity.json.example → git/identity.json and fill in your details."
        )
        return

    identity = json.loads(identity_file.read_text(encoding="utf-8"))

    is_headless = not (os.environ.get("DISPLAY") or os.environ.get("WAYLAND_DISPLAY"))

    content = setup_include(gitconfig_local, global_gitconfig)
    setup_identity(global_gitconfig, identity)
    setup_allowed_signers(identity["email"], identity["signingkey"])

    # Headless optimization only (no private data leaked)
    if is_headless and "[credential]" not in content:
        with open(global_gitconfig, "a", encoding="utf-8") as f:
            f.write("\n[credential]\n    helper = store\n")
        print("🖥️  Headless environment: Configured credential.helper to store locally.")


if __name__ == "__main__":
    main()
