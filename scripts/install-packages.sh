#!/usr/bin/env bash
# Install the system packages gud-vim expects. Reads from the existing
# package lists at the repo root:
#   homebrew.list  (macOS, one package per line)
#   deb-pkgs.txt   (Debian/Ubuntu, one package per line)
#
# Safe to re-run: brew/apt both skip packages that are already present.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

die() { printf 'install-packages: %s\n' "$*" >&2; exit 1; }

case "$(uname -s)" in
    Darwin)
        command -v brew >/dev/null 2>&1 || die "brew not found. Install Homebrew first: https://brew.sh"
        list="$REPO_DIR/homebrew.list"
        [[ -r "$list" ]] || die "missing $list"
        echo "==> brew install (from $list)"
        xargs brew install < "$list"
        ;;
    Linux)
        if ! command -v apt-get >/dev/null 2>&1; then
            die "only apt-based distros are handled. Your PM is not apt."
        fi
        list="$REPO_DIR/deb-pkgs.txt"
        [[ -r "$list" ]] || die "missing $list"
        echo "==> apt-get install (from $list)"
        sudo apt-get update
        xargs sudo apt-get install -y < "$list"
        ;;
    *)
        die "unsupported OS: $(uname -s)"
        ;;
esac

echo
echo "Optional: create a venv for the python linters"
echo "  cd \"$REPO_DIR\" && python3 -m venv venv && source venv/bin/activate && pip3 install -r requirements.txt"
