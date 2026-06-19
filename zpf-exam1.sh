#!/bin/bash
#
# zpf-exam1.sh — Final Exam Item 003 Script
# Creates mango-N.MP3 files in zpfgit/ directory
# Author: zhangpengfei
# Student ID: 202314060218
# Fruit: mango (last digit 8, 8%5=3)

set -euo pipefail

# Track files created by THIS script run (for cleanup)
CREATED_FILES=()

# Cleanup function: remove files created during this run
cleanup() {
    for f in "${CREATED_FILES[@]}"; do
        if [ -f "$f" ]; then
            rm -f "$f"
        fi
    done
}

# Trap signals for cleanup — covers normal exit, Ctrl+C, and kill
trap cleanup EXIT INT TERM

# ── Parameter validation ──────────────────────────────────────────

if [ $# -ne 1 ]; then
    echo "Error: Script requires exactly one positive integer parameter."
    read -rp "Press any key to exit..."
    exit 1
fi

n="$1"

# Must be a positive integer (no leading zeros, no decimals, no negatives)
if ! [[ "$n" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: Parameter must be a positive integer (e.g. 3, 10, 42)."
    read -rp "Press any key to exit..."
    exit 1
fi

echo "zhangpengfei will create $n files"

# ── Switch to zpfgit directory ─────────────────────────────────────

cd zpfgit || {
    echo "Error: Cannot change to zpfgit directory. Make sure it exists."
    exit 1
}

# ── Fruit name ─────────────────────────────────────────────────────
# Last digit of student ID 202314060218 is 8
# 8 mod 5 = 3 → mango
FRUIT="mango"

NEW_FILES=()

for ((i = 1; i <= n; i++)); do
    filename="${FRUIT}-${i}.MP3"
    if [ -e "$filename" ]; then
        echo "File $filename already exists, skipping."
    else
        touch "$filename"
        CREATED_FILES+=("$filename")
        NEW_FILES+=("$filename")
    fi
done

# ── Output results ─────────────────────────────────────────────────

echo "zhangpengfei fin"

if [ ${#NEW_FILES[@]} -gt 0 ]; then
    echo "Newly created files:"
    printf '%s\n' "${NEW_FILES[@]}"
else
    echo "No new files were created (all already existed)."
fi

echo "Current time T2: $(date '+%Y-%m-%d %H:%M:%S')"
read -rp "Press any key to exit..."

