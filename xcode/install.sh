#!/bin/bash

# Install Bex Codes themes for Xcode
# This script creates symbolic links to the theme files in the Xcode UserData directory

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
XCODE_THEMES_DIR="$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes"

# Create the Xcode themes directory if it doesn't exist
mkdir -p "$XCODE_THEMES_DIR"

# Remove existing symlinks if they exist
rm -f "$XCODE_THEMES_DIR/Bex Codes.xccolortheme"
rm -f "$XCODE_THEMES_DIR/Bex Codes Light.xccolortheme"
rm -f "$XCODE_THEMES_DIR/Catppuccin Mocha.xccolortheme"

# Create symlinks
ln -sf "$SCRIPT_DIR/Bex Codes.xccolortheme" "$XCODE_THEMES_DIR/Bex Codes.xccolortheme"
ln -sf "$SCRIPT_DIR/Bex Codes Light.xccolortheme" "$XCODE_THEMES_DIR/Bex Codes Light.xccolortheme"
ln -sf "$SCRIPT_DIR/Catppuccin Mocha.xccolortheme" "$XCODE_THEMES_DIR/Catppuccin Mocha.xccolortheme"

echo "✓ Xcode themes installed successfully"
echo "  Themes are now available in Xcode > Settings > Themes"
echo ""
echo "  Installed themes:"
echo "    - Bex Codes (dark)"
echo "    - Bex Codes Light"
echo "    - Catppuccin Mocha"
