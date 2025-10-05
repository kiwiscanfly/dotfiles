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

## Setup

1. Install Stow:
   ```bash
   brew install stow  # macOS
   ```

2. Clone this repo:
   ```bash
   git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

3. Install configs:
   ```bash
   stow <folder>  # Install specific config
   stow           # Install all configs
   ```

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
