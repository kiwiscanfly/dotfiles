#!/bin/bash

# Random welcome message script for terminal startup
# Uses figlet, lolcat, and gum for cute rainbow messages with system info

# Path to the welcome messages file
WELCOME_FILE="$HOME/dotfiles/scripts/welcome.txt"

# Check if required tools are installed
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

# Array of smaller, cleaner figlet fonts
FONTS=("small" "smshadow" "smslant" "contessa" "mini" "script" "shadow" "stampatello" "cybermedium" "standard" "thin")

# Array of cute emojis for separator
EMOJIS=("✨" "🌸" "🎀" "💖" "🌈" "⭐" "🦄" "🌺" "💫" "🌟" "💝" "🎨" "🔮" "🌙" "☁️" "🍭")
RANDOM_EMOJI1=${EMOJIS[$RANDOM % ${#EMOJIS[@]}]}
RANDOM_EMOJI2=${EMOJIS[$RANDOM % ${#EMOJIS[@]}]}

# Get random font
RANDOM_FONT=${FONTS[$RANDOM % ${#FONTS[@]}]}

# Create system info box using gum if available
if command -v gum &> /dev/null && command -v paste &> /dev/null; then
    # Get system info
    DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
    UPTIME=$(uptime | sed 's/.*up //' | sed 's/, [0-9]* user.*//')
    GIT_BRANCH=$(git branch --show-current 2>/dev/null || echo "not in repo")
    DATE_TIME=$(date "+%a %b %d %I:%M %p")
    
    # Create the welcome message
    WELCOME_OUTPUT=$(echo "$RANDOM_MESSAGE" | figlet -f "$RANDOM_FONT" 2>/dev/null || echo "$RANDOM_MESSAGE" | figlet)
    
    # Create info box with gum
    INFO_BOX=$(gum style \
        --foreground 219 \
        --border rounded \
        --border-foreground 213 \
        --padding "0 2" \
        --margin "0" \
        --align left \
        "💾 Disk: $DISK_USAGE used" \
        "⏰ Uptime: $UPTIME" \
        "🌿 Branch: $GIT_BRANCH" \
        "📅 Time: $DATE_TIME")
    
    # Get terminal width to calculate spacing
    TERM_WIDTH=$(tput cols)
    
    # Create temp files for processing
    TEMP_WELCOME=$(mktemp)
    TEMP_INFO=$(mktemp)
    
    # Write outputs to temp files
    echo "$WELCOME_OUTPUT" > "$TEMP_WELCOME"
    echo "$INFO_BOX" > "$TEMP_INFO"
    
    # Find the maximum width of the welcome message
    MAX_WELCOME_WIDTH=$(awk '{ gsub(/\x1b\[[0-9;]*m/, ""); if (length > max) max = length } END { print max }' "$TEMP_WELCOME")
    
    # Calculate if we have enough space for side-by-side
    REQUIRED_WIDTH=$((MAX_WELCOME_WIDTH + 40))  # 40 for info box plus spacing
    
    if [ $TERM_WIDTH -gt $REQUIRED_WIDTH ]; then
        # Use paste to combine side by side with info box on the LEFT
        paste "$TEMP_INFO" "$TEMP_WELCOME" | lolcat
    else
        # If terminal too narrow, display info box on top, then welcome message
        echo "$INFO_BOX"
        echo ""
        echo "$WELCOME_OUTPUT" | lolcat
    fi
    
    # Clean up temp files
    rm -f "$TEMP_WELCOME" "$TEMP_INFO"
else
    # Fallback to simple display without gum
    echo "$RANDOM_MESSAGE" | figlet -f "$RANDOM_FONT" 2>/dev/null | lolcat || echo "$RANDOM_MESSAGE" | figlet | lolcat
fi

# Cute separator with random emojis
SEPARATOR="${RANDOM_EMOJI1}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RANDOM_EMOJI2}"
echo ""
echo "$SEPARATOR" | lolcat