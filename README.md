# Dotfiles

My personal configuration files managed with GNU Stow.

## Required Applications

### Core Tools

**Shell & Terminal:**
- `zsh` - Shell (default on macOS)
- `oh-my-zsh` - Zsh framework
- `powerlevel10k` - Zsh theme
- `tmux` - Terminal multiplexer

**Package Manager:**
- `homebrew` - macOS package manager

### Window Management & Editors
- `aerospace` - Tiling window manager
- `neovim` (nvim) - Text editor
- `vscode` (code) - VS Code editor

### Development Tools

**Version Managers:**
- `nvm` - Node version manager
- `fvm` - Flutter version manager
- `direnv` - Auto-load environment variables

**Languages & Frameworks:**
- `node` - JavaScript runtime (via nvm)
- `flutter` & `dart` - Flutter development
- `docker` - Containerization

**CLI Tools:**
- `git` - Version control
- `aws` - AWS CLI
- `gh` - GitHub CLI
- `1password` - 1Password CLI

### Visual & Display Tools
- `figlet` - ASCII art text
- `lolcat` - Rainbow colorizer
- `gum` - Styled terminal UI components
- `eza` - Modern ls replacement
- `bat` - Syntax-highlighted cat with themes
- `git-delta` - Beautiful git diffs
- `glow` - Markdown renderer
- `tldr` - Simplified command help

### Search & Navigation Tools
- `ripgrep` (rg) - Fast text search
- `fd` - Fast file finder
- `fzf` - Fuzzy finder
- `lazygit` - Terminal UI for git

### Neovim Plugins (via lazy.nvim)
- `lazy.nvim` - Plugin manager
- `telescope.nvim` - Fuzzy finder
- `neo-tree.nvim` - File explorer
- `nvim-treesitter` - Syntax highlighting
- `nvim-lspconfig` - LSP configuration
- `nvim-cmp` - Autocompletion
- `copilot.lua` & `copilot-cmp` - GitHub Copilot
- `conform.nvim` - Code formatting

### Tmux Plugins (via tpm)
- `tpm` - Tmux plugin manager
- `tmux-sensible` - Sensible defaults
- `vim-tmux-navigator` - Vim-tmux navigation
- `catppuccin/tmux` - Catppuccin theme
- `tmux-yank` - Copy to system clipboard

### Zsh Plugins
- `zsh-syntax-highlighting` - Command syntax highlighting
- `zsh-autosuggestions` - Command suggestions (via Homebrew)
- `fzf` - Fuzzy finder
- `fzf-tab` - FZF-powered tab completion (via Oh My Zsh)

### Optional/System
- `anaconda3` - Python distribution
- `docker-compose` - Multi-container Docker

## Installation (macOS)

### 1. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Core Tools
```bash
brew install git stow neovim tmux
```

### 3. Install CLI Tools
```bash
brew install \
  bat \
  eza \
  fd \
  figlet \
  fzf \
  git-delta \
  glow \
  gum \
  lazygit \
  lolcat \
  ripgrep \
  tldr \
  direnv \
  gh \
  awscli \
  1password-cli
```

### 4. Install Aerospace (Window Manager)
```bash
brew install --cask aerospace
```

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

**zsh-autosuggestions:**
```bash
brew install zsh-autosuggestions
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

## Setup Dotfiles

After completing the installation steps above:

1. Clone this repo:
   ```bash
   git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Symlink configs with Stow:
   ```bash
   stow .  # Install all configs
   ```

   Or install specific configs:
   ```bash
   stow <folder>  # Install specific config (e.g., stow nvim)
   ```

3. Reload your shell:
   ```bash
   source ~/.zshrc
   ```

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
- `help` - tldr for quick command help

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
