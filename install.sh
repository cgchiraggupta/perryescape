#!/bin/bash
# ============================================================
# perryescape — Master Bootstrap Installer
# Usage: ./install.sh [--dotfiles] [--brew] [--scripts] [--all]
# ============================================================
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/dotfiles" && pwd)"
SCRIPTS_DIR="$(cd "$(dirname "$0")/scripts" && pwd)"
BREWFILE="$(cd "$(dirname "$0")" && pwd)/Brewfile"

do_brew=false
do_dotfiles=false
do_scripts=false

# Parse args
if [ $# -eq 0 ]; then
  do_brew=true
  do_dotfiles=true
  do_scripts=true
else
  for arg in "$@"; do
    case "$arg" in
      --brew|--brewfile) do_brew=true ;;
      --dotfiles) do_dotfiles=true ;;
      --scripts) do_scripts=true ;;
      --all) do_brew=true; do_dotfiles=true; do_scripts=true ;;
      --help|-h) echo "Usage: ./install.sh [--brew] [--dotfiles] [--scripts] [--all]"; exit 0 ;;
      *) echo "Unknown: $arg"; exit 1 ;;
    esac
  done
fi

echo "⚡ perryescape bootstrap starting..."

# ── Homebrew ──────────────────────────────────────────────
if $do_brew; then
  echo ""
  echo "=== 🍺 Homebrew ==="
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  echo "Updating Homebrew..."
  brew update --quiet
  echo "Installing from Brewfile..."
  brew bundle --file="$BREWFILE" --no-lock --quiet 2>/dev/null || true
  echo "✅ Homebrew done"
fi

# ── Dotfiles ──────────────────────────────────────────────
if $do_dotfiles; then
  echo ""
  echo "=== ⚙️  Dotfiles ==="

  # .zshrc
  if [ -f "$DOTFILES_DIR/zshrc" ]; then
    if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
      cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%s)"
      echo "  ↪ Backed up existing .zshrc"
    fi
    ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
    echo "  ✓ .zshrc linked"
  fi

  # .gitconfig
  if [ -f "$DOTFILES_DIR/gitconfig" ]; then
    if [ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ]; then
      cp "$HOME/.gitconfig" "$HOME/.gitconfig.backup.$(date +%s)"
    fi
    ln -sf "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
    echo "  ✓ .gitconfig linked"
  fi

  # .gitignore global
  if [ -f "$DOTFILES_DIR/gitignore" ]; then
    ln -sf "$DOTFILES_DIR/gitignore" "$HOME/.gitignore"
    git config --global core.excludesfile "$HOME/.gitignore" 2>/dev/null || true
    echo "  ✓ .gitignore linked"
  fi

  # SSH config (copy, don't symlink — might vary by machine)
  if [ -f "$DOTFILES_DIR/ssh-config" ]; then
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    if [ ! -f "$HOME/.ssh/config" ]; then
      cp "$DOTFILES_DIR/ssh-config" "$HOME/.ssh/config"
      chmod 600 "$HOME/.ssh/config"
      echo "  ✓ .ssh/config created from template"
    else
      echo "  ~ .ssh/config already exists, skipping"
    fi
  fi

  echo "✅ Dotfiles done"
fi

# ── Scripts ────────────────────────────────────────────────
if $do_scripts; then
  echo ""
  echo "=== 🛠️  Scripts ==="

  TARGET_DIR="$HOME/.local/bin"
  mkdir -p "$TARGET_DIR"

  if [ -d "$SCRIPTS_DIR" ]; then
    for script in "$SCRIPTS_DIR"/*; do
      [ -f "$script" ] || continue
      name="$(basename "$script")"
      chmod +x "$script"
      ln -sf "$script" "$TARGET_DIR/$name"
      echo "  ✓ $name → $TARGET_DIR/"
    done
  fi

  # Ensure ~/.local/bin is in PATH
  case ":$PATH:" in
    *":$TARGET_DIR:"*) ;;
    *) echo "  ⚠  Add to your shell: export PATH=\"$TARGET_DIR:\$PATH\"" ;;
  esac

  echo "✅ Scripts done"
fi

echo ""
echo "🎉 perryescape bootstrap complete!"
echo "   Restart your shell or run: source ~/.zshrc"
