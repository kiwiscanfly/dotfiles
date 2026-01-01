# macOS Installation

## Prerequisites

- macOS with admin access
- Git (comes with Xcode Command Line Tools)

## Installation Steps

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone Repository

```bash
git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Install Homebrew Packages

```bash
brew bundle install
```

This installs all formulae and casks from the [Brewfile](../Brewfile).

### 4. Install LaTeX Packages

Required for Neovim math rendering in markdown:

```bash
sudo /Library/TeX/texbin/tlmgr update --self
sudo /Library/TeX/texbin/tlmgr install standalone varwidth preview amsmath amsfonts amssymb mathtools dvipng dvisvgm
```

### 5. Install FZF Key Bindings

```bash
$(brew --prefix)/opt/fzf/install
```

### 6. Install Tmux Plugin Manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

After installing, open tmux and press `prefix + I` (Ctrl+b, then Shift+I) to install plugins.

### 7. Symlink Dotfiles

```bash
cd ~/dotfiles
stow .
```

Or symlink specific configs:

```bash
stow nvim    # Only Neovim
stow tmux    # Only Tmux
```

### 8. Configure Lazygit

Lazygit on macOS uses `~/Library/Application Support/lazygit/`:

```bash
mkdir -p ~/Library/Application\ Support/lazygit
rm -f ~/Library/Application\ Support/lazygit/config.yml
ln -s ~/dotfiles/.config/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml
```

### 9. Build Bat Cache

Enable custom syntax themes:

```bash
bat cache --build
```

### 10. Install Node.js Tools

After installing Node.js via nvm:

```bash
npm install -g tree-sitter-cli
```

Required for compiling some Neovim treesitter parsers.

### 11. Install VSCode Extensions

```bash
cd ~/dotfiles/vscode
./manage-extensions.sh install
```

### 12. Reload Shell

```bash
source ~/.zshrc
```

## What Happens Automatically

- **Antidote** clones and installs Zsh plugins from `.zsh_plugins.txt`
- **lazy.nvim** installs Neovim plugins on first launch
- **TPM** installs Tmux plugins when you press `prefix + I`

## Manual Downloads

These are not available via Homebrew:

- [VSCode](https://code.visualstudio.com)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
