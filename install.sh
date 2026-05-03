#!/usr/bin/env bash
# claude-agents-toolkit installer
# Idempotent: safe to re-run. Existing ~/.claude/agents/ is backed up before overwrite.

set -euo pipefail

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SRC_DIR="${SCRIPT_DIR}/agents"
DEST_DIR="${HOME}/.claude/agents"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="${HOME}/.claude/agents.backup.${TIMESTAMP}"

color_red()    { printf '\033[31m%s\033[0m\n' "$*"; }
color_green()  { printf '\033[32m%s\033[0m\n' "$*"; }
color_yellow() { printf '\033[33m%s\033[0m\n' "$*"; }
color_blue()   { printf '\033[34m%s\033[0m\n' "$*"; }

# 1. Sanity check source
if [[ ! -d "${SRC_DIR}" ]]; then
    color_red "ERROR: source agents/ directory not found at ${SRC_DIR}"
    color_red "Run this script from the cloned repo root."
    exit 1
fi

agent_count=$(find "${SRC_DIR}" -name '*.md' -type f | wc -l | tr -d ' ')
if [[ "${agent_count}" -eq 0 ]]; then
    color_red "ERROR: no .md agent files found in ${SRC_DIR}"
    exit 1
fi
color_blue "Found ${agent_count} agent files in source."

# 2. Ensure ~/.claude exists
mkdir -p "${HOME}/.claude"

# 3. Backup existing agents/ if present and non-empty
if [[ -d "${DEST_DIR}" ]] && [[ -n "$(ls -A "${DEST_DIR}" 2>/dev/null)" ]]; then
    color_yellow "Existing ${DEST_DIR} found — backing up to ${BACKUP_DIR}"
    cp -R "${DEST_DIR}" "${BACKUP_DIR}"
    color_green "Backup complete."
fi

# 4. Create destination
mkdir -p "${DEST_DIR}"

# 5. Copy preserving subdirectory structure
color_blue "Installing agents to ${DEST_DIR}..."
cp -R "${SRC_DIR}/." "${DEST_DIR}/"

# 6. Verify
installed_count=$(find "${DEST_DIR}" -name '*.md' -type f | wc -l | tr -d ' ')
if [[ "${installed_count}" -ne "${agent_count}" ]]; then
    color_red "WARNING: installed ${installed_count} but source has ${agent_count} — partial install?"
else
    color_green "Installed ${installed_count} agents successfully."
fi

# 7. Show layout
color_blue ""
color_blue "Final ${DEST_DIR} layout:"
if command -v tree >/dev/null 2>&1; then
    tree -L 2 "${DEST_DIR}"
else
    find "${DEST_DIR}" -type f -name '*.md' | sort | sed "s|${DEST_DIR}/||"
fi

color_green ""
color_green "claude-agents-toolkit installed."
color_green "   Restart Claude Code session, or run /agents to see new agents."
if [[ -d "${BACKUP_DIR}" ]]; then
    color_yellow "   Previous agents backed up at: ${BACKUP_DIR}"
fi
