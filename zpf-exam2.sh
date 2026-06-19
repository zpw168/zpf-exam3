#!/bin/bash
#
# zpf-exam2.sh — Final Exam Item 004 Script
# Validate student ID, validate major name, simulate user creation
# Author: zhangpengfei
# Student ID: 202314060218

set -euo pipefail

# ── Clear screen ───────────────────────────────────────────────────

clear

# ── Student ID input and validation ────────────────────────────────
# Valid format: optional 'Z' followed by exactly 12 digits
#   Valid examples:   Z202214050219, 202014060250
#   Invalid examples: 3721, 2020aaaa01B2, 13722225555, process

echo "============================================"
echo "  Student Account Creation Simulator"
echo "============================================"
echo ""

while true; do
    read -rp "Please enter student ID (or type 'quit' to exit): " student_id

    if [ "$student_id" = "quit" ] || [ "$student_id" = "QUIT" ]; then
        echo "Exiting program."
        exit 0
    fi

    if [[ "$student_id" =~ ^Z?[0-9]{12}$ ]]; then
        echo "Student ID format is valid."
        break
    else
        echo "Error: Invalid student ID format."
        echo "  Valid format: optional 'Z' followed by exactly 12 digits."
        echo "  Examples: Z202214050219, 202014060250"
        echo ""
    fi
done

echo ""

# ── Major name input and validation ────────────────────────────────
# Must be English letters only

while true; do
    read -rp "Please enter major name (English letters only, or 'quit' to exit): " major

    if [ "$major" = "quit" ] || [ "$major" = "QUIT" ]; then
        echo "Exiting program."
        exit 0
    fi

    if [[ "$major" =~ ^[a-zA-Z]+$ ]]; then
        echo "Major name format is valid."
        break
    else
        echo "Error: Major name must contain only English letters (a-z, A-Z)."
        echo ""
    fi
done

echo ""

# ── Check if user exists and output action ─────────────────────────

if getent passwd "$student_id" >/dev/null 2>&1; then
    echo "User '$student_id' already exists on the system."
else
    echo "User '$student_id' does not exist."
    echo ""
    echo "To create this user, run the following command:"
    echo "  sudo useradd -m -g $major $student_id"
    echo ""
    echo "(Note: This script only DISPLAYS the command; it does NOT execute it.)"
fi

echo ""
echo "============================================"
echo "Current time T3: $(date '+%Y-%m-%d %H:%M:%S')"
echo "============================================"
read -rp "Press any key to exit..."

