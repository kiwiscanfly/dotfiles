#!/bin/bash

# OBS Studio Settings Installer
# Creates symbolic links from dotfiles to OBS Studio's Application Support directory
# This keeps all settings under source control

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OBS_CONFIG_DIR="$HOME/Library/Application Support/obs-studio"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing OBS Studio settings...${NC}"

# Check if OBS has been run at least once
if [ ! -d "$OBS_CONFIG_DIR" ]; then
    echo -e "${YELLOW}OBS config directory not found. Creating it...${NC}"
    mkdir -p "$OBS_CONFIG_DIR/basic"
    mkdir -p "$OBS_CONFIG_DIR/plugin_config"
fi

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    local name="$3"

    if [ -L "$target" ]; then
        echo -e "${YELLOW}○ $name (symlink already exists, updating)${NC}"
        rm "$target"
    elif [ -e "$target" ]; then
        echo -e "${YELLOW}○ $name (backing up existing to .bak)${NC}"
        mv "$target" "${target}.bak"
    fi

    ln -s "$source" "$target"
    echo -e "${GREEN}✓ $name linked${NC}"
}

# Link scenes directory
echo -e "\n${BLUE}Linking scenes...${NC}"
if [ -d "$OBS_CONFIG_DIR/basic/scenes" ] && [ ! -L "$OBS_CONFIG_DIR/basic/scenes" ]; then
    echo -e "${YELLOW}Backing up existing scenes directory...${NC}"
    mv "$OBS_CONFIG_DIR/basic/scenes" "$OBS_CONFIG_DIR/basic/scenes.bak"
fi
create_symlink "$SCRIPT_DIR/basic/scenes" "$OBS_CONFIG_DIR/basic/scenes" "basic/scenes"

# Link profiles directory
echo -e "\n${BLUE}Linking profiles...${NC}"
if [ -d "$OBS_CONFIG_DIR/basic/profiles" ] && [ ! -L "$OBS_CONFIG_DIR/basic/profiles" ]; then
    echo -e "${YELLOW}Backing up existing profiles directory...${NC}"
    mv "$OBS_CONFIG_DIR/basic/profiles" "$OBS_CONFIG_DIR/basic/profiles.bak"
fi
create_symlink "$SCRIPT_DIR/basic/profiles" "$OBS_CONFIG_DIR/basic/profiles" "basic/profiles"

# Link obs-websocket plugin config
echo -e "\n${BLUE}Linking plugin configs...${NC}"
mkdir -p "$OBS_CONFIG_DIR/plugin_config"
if [ -d "$OBS_CONFIG_DIR/plugin_config/obs-websocket" ] && [ ! -L "$OBS_CONFIG_DIR/plugin_config/obs-websocket" ]; then
    echo -e "${YELLOW}Backing up existing obs-websocket config...${NC}"
    mv "$OBS_CONFIG_DIR/plugin_config/obs-websocket" "$OBS_CONFIG_DIR/plugin_config/obs-websocket.bak"
fi
create_symlink "$SCRIPT_DIR/plugin_config/obs-websocket" "$OBS_CONFIG_DIR/plugin_config/obs-websocket" "plugin_config/obs-websocket"

echo -e "\n${GREEN}✓ OBS Studio settings linked successfully!${NC}"
echo -e "${BLUE}All changes in OBS will be tracked in git.${NC}"
echo -e "${YELLOW}Note: Restart OBS Studio to apply changes.${NC}"
echo -e "${YELLOW}Note: Audio/video devices may need reconfiguration on new machines.${NC}"
