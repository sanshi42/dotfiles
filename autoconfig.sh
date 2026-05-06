#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="$HOME/.dotfiles-backup"
BACKUP_DIR="$BACKUP_ROOT/$(date +%Y%m%d-%H%M%S)"
BACKUP_KEEP="${DOTFILES_BACKUP_KEEP:-3}"

prune_backups() {
    if [[ ! "$BACKUP_KEEP" =~ ^[0-9]+$ ]]; then
        printf 'warning: DOTFILES_BACKUP_KEEP must be a non-negative integer, got %s\n' "$BACKUP_KEEP" >&2
        return
    fi

    if [ "$BACKUP_KEEP" -eq 0 ] || [ ! -d "$BACKUP_ROOT" ]; then
        return
    fi

    local -a backups=()
    mapfile -t backups < <(find "$BACKUP_ROOT" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)

    local excess=$(( ${#backups[@]} - BACKUP_KEEP ))
    if [ "$excess" -le 0 ]; then
        return
    fi

    local backup_name
    local i
    for ((i = 0; i < excess; i++)); do
        backup_name="${backups[$i]}"
        rm -rf -- "$BACKUP_ROOT/$backup_name"
        printf 'prune: %s/%s\n' "$BACKUP_ROOT" "$backup_name"
    done
}

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

prune_backups
