# Sublime Text Configuration

This directory contains Sublime Text settings that are managed via symbolic links.

## Files

- **Preferences.sublime-settings** - Main editor preferences (font, theme, etc.)
- **Package Control.sublime-settings** - Installed packages list
- **install.sh** - Script to create symbolic links to Application Support

## Installation

Run the install script to create symbolic links:

```bash
cd ~/dotfiles/sublime-text
./install.sh
```

This will:
1. Create symlinks from this directory to `~/Library/Application Support/Sublime Text/Packages/User/`
2. Link the Bex Codes theme from the bat themes directory
3. Keep all changes under source control automatically

## Theme

The **Bex-Codes.tmTheme** is symlinked from `.config/bat/themes/Bex-Codes.tmTheme` to ensure consistency across bat, VS Code, neovim, and Sublime Text.

## Making Changes

Edit files directly in Sublime Text - changes will be reflected in this git repository automatically due to the symlinks.
