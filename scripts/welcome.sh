#!/bin/bash

# Random welcome message script for terminal startup
# Uses figlet and lolcat for cute rainbow messages

# Path to the welcome messages file
WELCOME_FILE="$HOME/dotfiles/scripts/welcome.txt"

# Check if figlet and lolcat are installed
if ! command -v figlet &> /dev/null; then
    echo "figlet not found. Install with: brew install figlet"
    exit 1
fi

if ! command -v lolcat &> /dev/null; then
    echo "lolcat not found. Install with: brew install lolcat"
    exit 1
fi

# Check if welcome file exists
if [[ ! -f "$WELCOME_FILE" ]]; then
    echo "Welcome file not found at $WELCOME_FILE"
    exit 1
fi

# Get random line from welcome file (macOS compatible)
RANDOM_MESSAGE=$(sort -R "$WELCOME_FILE" | head -n 1)

# Array of cute figlet fonts
FONTS=("contessa" "gothic" "banner" "3-d" "avatar" "broadway" "chunky" "colossal" "digital" "doom" "epic" "fuzzy" "ghost" "graffiti" "bulbhead" "letters" "nancyj" "puffy" "rounded" "shadow" "slant" "small" "smslant" "speed" "starwars" "stop" "thick")

# Get random font
RANDOM_FONT=${FONTS[$RANDOM % ${#FONTS[@]}]}

# Display the message with random figlet font and lolcat
echo "$RANDOM_MESSAGE" | figlet -f "$RANDOM_FONT" 2>/dev/null | lolcat || echo "$RANDOM_MESSAGE" | figlet | lolcat

# Optional: Add a cute separator
echo "✨━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━>>>✨" | lolcat