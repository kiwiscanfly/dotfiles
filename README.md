# Dotfiles

My personal configuration files managed with GNU Stow.

## Overview

This repository contains configurations for:
- **Terminal:** Ghostty with Catppuccin themes, Zsh with Powerlevel10k, Tmux
- **Editor:** Neovim with LSP, Treesitter, and Copilot
- **Window Manager:** Aerospace tiling window manager
- **CLI Tools:** Modern replacements (bat, eza, fzf, ripgrep) and development tools
- **Development:** Flutter, Node.js, Python, PHP, Docker, AWS, and more

### Package Management

All Homebrew packages are documented in [`Brewfile`](Brewfile) with detailed descriptions:
- **46 formulae** - CLI tools, libraries, and development tools
- **5 casks** - GUI applications (Ghostty, Aerospace, Anaconda, etc.)
- **64 VSCode extensions** - Complete development environment

**Non-Homebrew Dependencies:**
- **VSCode** - [Download from code.visualstudio.com](https://code.visualstudio.com)
- **Docker Desktop** - [Download from docker.com](https://www.docker.com/products/docker-desktop)
- **Neovim plugins** - Managed by lazy.nvim (auto-installed)
- **Tmux plugins** - Managed by tpm
- **Zsh plugins** - Oh My Zsh, Powerlevel10k, and custom plugins

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

This will install all 46 formulae, 5 casks, and 64 VSCode extensions listed in the [`Brewfile`](Brewfile).

### 4. Install VSCode and Docker Desktop
- **VSCode:** [Download from code.visualstudio.com](https://code.visualstudio.com)
- **Docker Desktop:** [Download from docker.com](https://www.docker.com/products/docker-desktop)

### 5. Install Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 6. Install Powerlevel10k Theme
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### 7. Install Zsh Plugins

**fzf-tab:**
```bash
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
```

**zsh-syntax-highlighting:**
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-stuff/zsh-syntax-highlighting
```

### 8. Install FZF Key Bindings
```bash
$(brew --prefix)/opt/fzf/install
```

### 9. Install Tmux Plugin Manager (TPM)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

After installing, open tmux and press `prefix + I` (Ctrl+b, then Shift+I) to install tmux plugins.

### 10. Install Catppuccin Theme for Bat
```bash
mkdir -p ~/.config/bat/themes
cd ~/.config/bat/themes
curl -O https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin-Mocha.tmTheme
bat cache --build
```

### 11. Configure Git Delta
```bash
git config --global delta.syntax-theme "Catppuccin-Mocha"
```

### 12. Install Node.js Global Packages
After installing Node.js via nvm:

```bash
npm install -g tree-sitter-cli  # Required for Neovim treesitter parsers
```

### 13. Symlink Dotfiles with Stow
```bash
cd ~/dotfiles
stow .  # Symlink all configs
```

Or install specific configs:
```bash
stow nvim    # Symlink only Neovim config
stow tmux    # Symlink only Tmux config
```

### 14. Reload Your Shell
```bash
source ~/.zshrc
```

Neovim plugins will be automatically installed on first launch via lazy.nvim.

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
