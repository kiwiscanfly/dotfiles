# VS Code Configuration

This directory contains Visual Studio Code settings and configuration files for syncing across machines.

## Files

- `settings.json` - VS Code user settings
- `keybindings.json` - Custom keyboard shortcuts
- `extensions.txt` - List of installed extensions (created by manage-extensions.sh)
- `manage-extensions.sh` - Script for managing VS Code extensions

## Setup

### 1. Create Symbolic Links

Link these configuration files to VS Code's config directory:

#### macOS
```bash
# Create symlinks for settings and keybindings
ln -sf ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
```

#### Linux
```bash
# Create symlinks for settings and keybindings
ln -sf ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
ln -sf ~/dotfiles/vscode/keybindings.json ~/.config/Code/User/keybindings.json
```

#### Windows (PowerShell as Administrator)
```powershell
# Create symlinks for settings and keybindings
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Code\User\settings.json" -Target "$HOME\dotfiles\vscode\settings.json"
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Code\User\keybindings.json" -Target "$HOME\dotfiles\vscode\keybindings.json"
```

### 2. Manage Extensions

Use the included script to sync VS Code extensions:

```bash
# Save current extensions to extensions.txt
./manage-extensions.sh save

# Install extensions from extensions.txt
./manage-extensions.sh install

# Sync extensions (install missing, optionally remove extras)
./manage-extensions.sh sync

# Show differences between installed and saved
./manage-extensions.sh diff
```

## Initial Setup on New Machine

1. Clone your dotfiles repository
2. Create symbolic links (see above)
3. Install saved extensions:
   ```bash
   cd ~/dotfiles/vscode
   ./manage-extensions.sh install
   ```

## Updating Configuration

When you make changes to VS Code settings or install new extensions:

1. Settings and keybindings are automatically saved (via symlinks)
2. Update extensions list:
   ```bash
   ./manage-extensions.sh save
   ```
3. Commit changes to your dotfiles repository

## Troubleshooting

### Symbolic Links Not Working

If VS Code overwrites the symbolic links:
1. Back up the current VS Code settings
2. Delete the files in VS Code's config directory
3. Recreate the symbolic links

### Extension Installation Fails

If extensions fail to install:
- Ensure VS Code is installed and the `code` command is available in PATH
- On macOS, install the command from VS Code: `Cmd+Shift+P` → "Shell Command: Install 'code' command in PATH"
- Check network connection for marketplace access

### Finding VS Code Config Directory

To locate your VS Code configuration directory:
- Open VS Code
- Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Linux/Windows)
- Type "Preferences: Open User Settings (JSON)"
- Note the file path shown