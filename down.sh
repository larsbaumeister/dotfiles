#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

unlink_file() {
    local target="$1"
    if [ -L "$target" ]; then
        rm "$target"
        echo "Removed symlink: $target"
    else
        echo "Not a symlink, skipping: $target"
    fi
}

# Zsh
unlink_file "$HOME/.zshrc"
unlink_file "$HOME/.zsh/zsh-autosuggestions"

# Tmux
unlink_file "$HOME/.tmux.conf"
unlink_file "$HOME/.tmux/plugins/tpm"

# Neovim: remove entire config directory symlink
unlink_file "$HOME/.config/nvim"

# git
unlink_file "$HOME/.gitconfig"

echo "All dotfile symlinks removed successfully!"
