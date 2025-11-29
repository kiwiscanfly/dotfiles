# OBS Studio Configuration

This directory contains OBS Studio settings that are managed via symbolic links.

## Files

- **basic/scenes/** - Scene collections
- **basic/profiles/** - Streaming/recording profiles
- **plugin_config/obs-websocket/** - WebSocket plugin configuration
- **install.sh** - Script to create symbolic links to Application Support
- **plugins.txt** - List of OBS plugins with download URLs
- **manage-plugins.sh** - Script to check plugin installation status

**Note:** `global.ini` is not tracked because OBS overwrites symlinks for this file.

## Installation

Run the install script to create symbolic links:

```bash
cd ~/dotfiles/obs-studio
./install.sh
```

Check plugin status:

```bash
./manage-plugins.sh status
```

The install script will:
1. Back up any existing OBS configuration
2. Create symlinks from this directory to `~/Library/Application Support/obs-studio/`
3. Keep all changes under source control automatically

## Security Note

The following files contain secrets and are **gitignored** (not committed):
- `basic/profiles/*/service.json` - Streaming service credentials
- `plugin_config/obs-websocket/config.json` - WebSocket server password

These files are still symlinked for local backup but won't be pushed to git.

## Making Changes

Edit settings directly in OBS - changes will be reflected in this git repository automatically due to the symlinks.

## Caveats

When setting up on a new machine:
- **Audio/Video devices** will need reconfiguration (device IDs are machine-specific)
- **File paths** in scenes (images, videos, etc.) may need updating
- **Streaming credentials** in `service.json` need to be reconfigured (gitignored)
- **WebSocket password** in `plugin_config/obs-websocket/config.json` needs reconfiguration

## Directory Structure

```
obs-studio/
├── .gitignore
├── README.md
├── install.sh
├── manage-plugins.sh
├── plugins.txt
├── basic/
│   ├── scenes/
│   │   └── BexCodes.json
│   └── profiles/
│       └── BexCodes/
│           ├── basic.ini
│           └── service.json (gitignored)
└── plugin_config/
    └── obs-websocket/
        └── config.json (gitignored)
```
