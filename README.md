# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's Included

- **Shell:** Zsh with Starship prompt, Antidote plugins
- **Editor:** Neovim with LSP, Treesitter, Copilot
- **Terminal:** Ghostty, Tmux
- **File Manager:** Yazi
- **Email:** Neomutt with OAuth2
- **Music:** MPD + rmpc
- **CLI Tools:** bat, eza, fzf, ripgrep, lazygit, and more

Theme: **Bex Codes** (purple palette) - see [THEMES.md](THEMES.md)

## Quick Start

```bash
git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .
```

Full setup: [macOS](docs/install-macos.md) | [Arch Linux](docs/install-arch.md)

## Documentation

| Topic | Link |
|-------|------|
| Zsh Shortcuts | [docs/zsh-shortcuts.md](docs/zsh-shortcuts.md) |
| Neovim Keybindings | [docs/nvim-keybindings.md](docs/nvim-keybindings.md) |
| Tmux Keybindings | [docs/tmux-keybindings.md](docs/tmux-keybindings.md) |
| Hyprland (Linux) | [docs/hyprland-keybindings.md](docs/hyprland-keybindings.md) |
| Neomutt | [.config/neomutt/README.md](.config/neomutt/README.md) |
| rmpc Music Player | [.config/rmpc/README.md](.config/rmpc/README.md) |
| Themes | [THEMES.md](THEMES.md) |

## Homebrew

```bash
brew bundle install  # Install all packages from Brewfile
```
