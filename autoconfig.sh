#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link_file() {
    local source_file="$1"
    local target_file="$2"

    mkdir -p "$(dirname "$target_file")"

    if [ -L "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]; then
        printf 'skip: %s -> %s\n' "$target_file" "$source_file"
        return
    fi

    if [ -e "$target_file" ] || [ -L "$target_file" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target_file" "$BACKUP_DIR/"
        printf 'backup: %s -> %s/\n' "$target_file" "$BACKUP_DIR"
    fi

    ln -s "$source_file" "$target_file"
    printf 'link: %s -> %s\n' "$target_file" "$source_file"
}

dotfiles=(
    ".bashrc"
    ".gitconfig"
    ".ideavimrc"
    ".inputrc"
    ".tmux.conf"
    ".vimrc"
)

for dotfile in "${dotfiles[@]}"; do
    link_file "$DOTFILES_DIR/$dotfile" "$HOME/$dotfile"
done

link_file "$DOTFILES_DIR/vscode/settings.json" "$HOME/.config/Code/User/settings.json"
