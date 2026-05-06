#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_SKILLS_DIR="$SCRIPT_DIR/skills"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
INSTALLED_SKILLS_DIR="$CODEX_HOME/skills"

if [ ! -d "$INSTALLED_SKILLS_DIR" ]; then
    printf 'warning: Codex skills directory not found: %s\n' "$INSTALLED_SKILLS_DIR" >&2
    printf 'warning: start Codex once, then rerun sync.\n' >&2
    exit 0
fi

mkdir -p "$DOTFILES_SKILLS_DIR"

synced=0
for skill_dir in "$INSTALLED_SKILLS_DIR"/*; do
    [ -e "$skill_dir" ] || continue
    [ -d "$skill_dir" ] || continue

    skill_name="$(basename "$skill_dir")"
    if [ "$skill_name" = ".system" ]; then
        continue
    fi

    if [ -L "$skill_dir" ]; then
        printf 'skip: Codex skill %s is already linked\n' "$skill_name"
        continue
    fi

    if [ ! -f "$skill_dir/SKILL.md" ]; then
        printf 'warning: skipping Codex skill without SKILL.md: %s\n' "$skill_dir" >&2
        continue
    fi

    tmp_parent="$(mktemp -d /tmp/codex-skill-sync.XXXXXX)"
    cp -a "$skill_dir" "$tmp_parent/"
    rm -rf -- "$DOTFILES_SKILLS_DIR/$skill_name"
    mv "$tmp_parent/$skill_name" "$DOTFILES_SKILLS_DIR/$skill_name"
    rmdir "$tmp_parent"
    printf 'synced: %s -> %s/%s\n' "$skill_dir" "$DOTFILES_SKILLS_DIR" "$skill_name"
    synced=$((synced + 1))
done

if [ "$synced" -eq 0 ]; then
    printf 'no local Codex skills to sync\n'
else
    printf 'hint: review and commit %s\n' "$DOTFILES_SKILLS_DIR"
fi
