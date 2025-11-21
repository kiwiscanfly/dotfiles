#!/bin/bash

# Sublime Text Settings Installer
# Creates symbolic links from dotfiles to Sublime Text's Application Support directory
# This keeps all settings under source control

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUBLIME_USER_DIR="$HOME/Library/Application Support/Sublime Text/Packages/User"
BAT_THEME_SOURCE="$HOME/dotfiles/.config/bat/themes/Bex-Codes.tmTheme"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing Sublime Text settings...${NC}"

# Create Sublime Text User directory if it doesn't exist
if [ ! -d "$SUBLIME_USER_DIR" ]; then
    echo -e "${YELLOW}Creating Sublime Text User directory...${NC}"
    mkdir -p "$SUBLIME_USER_DIR"
fi

# Link settings files
echo -e "${GREEN}Creating symbolic links for settings files...${NC}"
ln -sf "$SCRIPT_DIR/Preferences.sublime-settings" "$SUBLIME_USER_DIR/Preferences.sublime-settings"
ln -sf "$SCRIPT_DIR/Package Control.sublime-settings" "$SUBLIME_USER_DIR/Package Control.sublime-settings"

# Link theme from bat themes
if [ -f "$BAT_THEME_SOURCE" ]; then
    echo -e "${GREEN}Linking Bex Codes theme from bat...${NC}"
    ln -sf "$BAT_THEME_SOURCE" "$SUBLIME_USER_DIR/Bex-Codes.tmTheme"
else
    echo -e "${YELLOW}Warning: Bex Codes theme not found at $BAT_THEME_SOURCE${NC}"
fi

echo -e "${GREEN}✓ Sublime Text settings linked successfully!${NC}"
echo -e "${BLUE}All changes in Sublime Text will be tracked in git.${NC}"
echo -e "${BLUE}Restart Sublime Text to apply changes.${NC}"
