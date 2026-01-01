# Dotfiles Project Instructions

## Critical Rules

1. **NO SECRETS COMMITTED** - Never commit credentials, API keys, tokens, or encryption secrets. Use `*.local` files (gitignored) for sensitive data.

2. **DOCUMENT EVERYTHING** - The purpose of this repo is to create consistent and reproducible setups across machines. Any configuration change that cannot be stored in a config file must be documented in the appropriate doc (e.g., manual steps in install guides).

## Repository Overview

This is a dotfiles repository managed with **GNU Stow**. Configs are symlinked to the home directory.

- **Primary target:** macOS
- **Secondary target:** Arch Linux
- **Theme:** Bex Codes (purple palette)

## File Organization

### Platform-Specific Configs
- Linux-only files are listed in `.stow-local-ignore` (not symlinked on macOS)
- Platform variants use `-linux` suffix (e.g., `config-linux.ron`, `mailcap-linux`)
- The base file (no suffix) is for macOS

### Secrets
- Local secrets go in `*.local` files (e.g., `.taskrc.local`)
- These are gitignored and not symlinked by stow
- Never commit credentials, API keys, or encryption secrets

### Key Directories
- `docs/` - Documentation (keybindings, installation guides)
- `scripts/` - Shell scripts (not symlinked, referenced directly)
- `.config/` - XDG config directory contents
- `linux-themes/` - GTK themes for Linux (not symlinked on macOS)

## Documentation Rules

### README.md
Keep minimal. Should contain:
- Brief overview of what's included
- Quick start (clone + `stow .`)
- Links to detailed docs

Move details to `docs/` directory.

### Keybinding Documentation
When adding or modifying keybindings in any application:
1. Update the corresponding doc in `docs/`
2. If no doc exists for that app, create one following the pattern in `docs/zsh-shortcuts.md`

Current keybinding docs:
- `docs/zsh-shortcuts.md` - Zsh shell shortcuts
- `docs/nvim-keybindings.md` - Neovim keymaps
- `docs/tmux-keybindings.md` - Tmux bindings
- `docs/hyprland-keybindings.md` - Hyprland WM (Linux)

App-specific READMEs with keybindings:
- `.config/neomutt/README.md` - Email client

### Installation Docs
- `docs/install-macos.md` - macOS setup steps
- `docs/install-arch.md` - Arch Linux setup

## Stow Usage

```bash
cd ~/dotfiles
stow .           # Symlink everything (respects .stow-local-ignore)
stow -D .        # Remove symlinks
stow --adopt .   # Adopt existing files into repo (use carefully)
```

## Common Patterns

### Adding a New Config
1. Create the config structure mirroring home directory
2. Add to `.stow-local-ignore` if Linux-only
3. Run `stow .` to create symlinks
4. Document any keybindings in `docs/`

### Platform-Specific Variants
```
.config/app/config          # macOS version
.config/app/config-linux    # Linux version (add to .stow-local-ignore)
```

On Linux, symlink manually: `ln -sf config-linux config`
