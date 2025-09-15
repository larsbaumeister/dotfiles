#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link_file() {
    local src="$1"
    local dest="$2"

    # Ensure parent directory exists
    mkdir -p "$(dirname "$dest")"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Removing existing file or directory: $dest"
        rm -rf "$dest"
    fi

    ln -s "$src" "$dest"
    echo "Linked: $dest -> $src"
}

# Zsh
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.zsh/zsh-autosuggestions" "$HOME/.zsh/zsh-autosuggestions"

# Tmux
link_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES_DIR/.tmux/plugins/tpm" "$HOME/.tmux/plugins/tpm"

# Neovim: link entire config directory
link_file "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

# Git
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

echo "✅ All dotfiles linked successfully!"

