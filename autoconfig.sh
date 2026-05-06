#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="$HOME/.dotfiles-backup"
BACKUP_DIR="$BACKUP_ROOT/$(date +%Y%m%d-%H%M%S)"
BACKUP_KEEP="${DOTFILES_BACKUP_KEEP:-3}"
CODEX_SKILLS_SOURCE_DIR="$DOTFILES_DIR/agents/codex/skills"

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

link_codex_skills() {
    if [ ! -d "$CODEX_SKILLS_SOURCE_DIR" ]; then
        return
    fi

    local codex_home="${CODEX_HOME:-$HOME/.codex}"
    local skills_dir="$codex_home/skills"
    mkdir -p "$skills_dir"

    local skill_dir
    local skill_name
    for skill_dir in "$CODEX_SKILLS_SOURCE_DIR"/*; do
        [ -e "$skill_dir" ] || continue
        [ -d "$skill_dir" ] || continue

        skill_name="$(basename "$skill_dir")"
        if [ "$skill_name" = ".system" ]; then
            continue
        fi

        if [ ! -f "$skill_dir/SKILL.md" ]; then
            printf 'warning: skipping Codex skill without SKILL.md: %s\n' "$skill_dir" >&2
            continue
        fi

        link_file "$skill_dir" "$skills_dir/$skill_name"
    done
}

install_git_hooks() {
    if ! command -v git >/dev/null 2>&1; then
        return
    fi

    local hook_source="$DOTFILES_DIR/agents/git-hooks/pre-commit"
    if [ ! -f "$hook_source" ]; then
        return
    fi

    local hook_target
    if ! hook_target="$(git -C "$DOTFILES_DIR" rev-parse --git-path hooks/pre-commit 2>/dev/null)"; then
        return
    fi

    case "$hook_target" in
        /*) ;;
        *) hook_target="$DOTFILES_DIR/$hook_target" ;;
    esac

    link_file "$hook_source" "$hook_target"
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

link_codex_skills
install_git_hooks
prune_backups
