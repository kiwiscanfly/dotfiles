# Dotfiles

My personal configuration files managed with GNU Stow.

## Overview

This repository contains configurations for:
- **Terminal:** Ghostty (with animated cursor shaders), Zsh with Starship prompt, Tmux
- **Editor:** Neovim with LSP, Treesitter, and Copilot
- **File Manager:** yazi with zoxide integration
- **Email:** neomutt with OAuth2 and LBDB contacts integration
- **Social Media:** toot Mastodon CLI and TUI client
- **Music Player:** MPD daemon with rmpc TUI client
- **CLI Tools:** Modern replacements (bat, eza, fzf, ripgrep) and development tools
- **Development:** Flutter, Node.js, Python, PHP, Docker, and more

See [Themes](#themes) section for custom color themes across all tools.

### Package Management

All Homebrew packages are documented in [`Brewfile`](Brewfile) with detailed descriptions:
- **69 formulae** - CLI tools, libraries, and development tools (including MPD music player and toot Mastodon client)
- **4 casks** - GUI applications and fonts (Ghostty, Hack Nerd Font, 1Password CLI, VS Code)
- **55 VSCode extensions** - Managed via `vscode/manage-extensions.sh` (separate from Brewfile)

**Non-Homebrew Dependencies:**
- **VSCode** - [Download from code.visualstudio.com](https://code.visualstudio.com)
- **Docker Desktop** - [Download from docker.com](https://www.docker.com/products/docker-desktop)
- **Neovim plugins** - Managed by lazy.nvim (auto-installed)
- **Tmux plugins** - Managed by tpm

## Installation (macOS)

### 1. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone this repository
```bash
git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Install all Homebrew packages
```bash
brew bundle install
```

This will install all 68 formulae and 4 casks listed in the [`Brewfile`](Brewfile). 

### 4. Install VSCode and Docker Desktop
- **VSCode:** [Download from code.visualstudio.com](https://code.visualstudio.com)
- **Docker Desktop:** [Download from docker.com](https://www.docker.com/products/docker-desktop)

### 5. Install FZF Key Bindings
```bash
$(brew --prefix)/opt/fzf/install
```

### 6. Install Tmux Plugin Manager (TPM)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

After installing, open tmux and press `prefix + I` (Ctrl+b, then Shift+I) to install tmux plugins.

### 7. Symlink Dotfiles with Stow
```bash
cd ~/dotfiles
stow .  # Symlink all configs
```

Or install specific configs:
```bash
stow nvim    # Symlink only Neovim config
stow tmux    # Symlink only Tmux config
```

### 8. Configure Lazygit (macOS)
Lazygit on macOS looks for its config in `~/Library/Application Support/lazygit/`, so we need to create a manual symlink:
```bash
mkdir -p ~/Library/Application\ Support/lazygit
rm -f ~/Library/Application\ Support/lazygit/config.yml
ln -s ~/dotfiles/.config/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml
```

### 9. Build Bat Cache
After symlinking dotfiles, build the bat cache to enable custom themes:
```bash
bat cache --build
```

### 10. Configure Git Delta
Ensure your `~/.gitconfig` includes the Delta themes file:
```gitconfig
[include]
    path = ~/dotfiles/.config/git/delta-themes.gitconfig

[delta]
    features = bex-codes
    navigate = true
    side-by-side = true
```

### 11. Install Node.js Global Packages
After installing Node.js via nvm:

```bash
npm install -g tree-sitter-cli  # Required for Neovim treesitter parsers
```

### 12. Install VSCode Extensions
```bash
cd ~/dotfiles/vscode
./manage-extensions.sh install
```

This will install all 55 extensions listed in `vscode/extensions.txt`.

### 13. Reload Your Shell
```bash
source ~/.zshrc
```

**What happens on first shell launch:**
- Antidote will automatically clone and install all Zsh plugins from `.zsh_plugins.txt`
- Neovim plugins will be automatically installed on first Neovim launch via lazy.nvim
- Tmux plugins will be installed when you press `prefix + I` in tmux

## Zsh Configuration

### Starship Prompt

This setup uses **[Starship](https://starship.rs)** with a custom configuration:
- Configuration file: `.config/starship.toml`
- Shows OS icon, username, directory, git status, language versions, Docker context, and time
- Two-line format with context-aware prompt character (including vim mode support)
- Rainbow-colored segments (see [Themes](#themes) section)
- To customize: Edit `.config/starship.toml` and see [Starship docs](https://starship.rs/config/)

### Plugin Management

This setup uses **Antidote** for managing Zsh plugins. All plugins are defined in `.zsh_plugins.txt`:

**Current plugins:**
- `lukechilds/zsh-nvm` - NVM with lazy loading and auto `.nvmrc` switching
- `zsh-users/zsh-syntax-highlighting` - Fish-like syntax highlighting
- `zsh-users/zsh-autosuggestions` - Fish-like autosuggestions

**To add more plugins:** Edit `.zsh_plugins.txt` and add the plugin in `user/repo` format. Reload your shell to install.

## Features

### Custom Functions

- **`fif <search-term>`** - Interactive file search with ripgrep and bat preview, opens in nvim
- **`fcd`** - Fuzzy directory navigation with eza tree preview
- **`fgb`** - Fuzzy git branch checkout
- **`fkill`** - Interactive process killer

### Key Bindings

- **`Ctrl+T`** - Fuzzy file finder with bat preview
- **`Alt+C`** - Fuzzy directory finder with eza preview
- **`Ctrl+R`** - Fuzzy command history search

### Aliases

**Enhanced Tools:**
- `cat` → `bat --style=plain` (syntax-highlighted cat)
- `ls` → `eza` with icons and colors
- `ll` → `eza -la` with git status
- `lt` → `eza --tree` (tree view)

**Git:**
- `gs` - git status
- `gd` - git diff (with delta)
- `gp` - git pull
- `gco` - git checkout
- `gb` - git branch
- `glog` - pretty git log
- `lg` - lazygit

**Documentation:**
- `mdv` - view markdown with glow

### Music Player

This setup uses **[MPD](https://www.musicpd.org/)** with **[rmpc](https://github.com/mierak/rmpc)** as a TUI client. Features include album art support and audio visualizer (cava).

**Quick access:** `prefix+t` in tmux (Ctrl+b, then t)

For detailed setup instructions, controls, and configuration details, see [`.config/rmpc/README.md`](.config/rmpc/README.md).

## Themes

This repository includes custom **Bex Codes** themes with a unified color palette across multiple applications including Ghostty, Neovim, VSCode, Tmux, Starship, bat, yazi, rmpc, and more.

For complete theme documentation including color mappings, installation notes, and the design philosophy, see **[THEMES.md](THEMES.md)**.

## Usage

Each folder represents a program's configuration that will be symlinked to your home directory.

Example structure:
```
vim/
└── .vimrc      # Will be linked to ~/.vimrc
```

To add all new configs run `stow .`

To add new configs:
```bash
mkdir program
cp ~/.programrc program/
stow program
```

To remove configs:
```bash
stow -D program
```
