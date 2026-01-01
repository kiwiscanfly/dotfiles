# Tmux Keybindings

Prefix key is `Ctrl+b`.

## Custom Bindings

| Shortcut | Action |
|----------|--------|
| `prefix + t` | Open rmpc music player in new window |
| `prefix + "` | Split pane vertically (keeps current path) |
| `prefix + %` | Split pane horizontally (keeps current path) |

## Copy Mode (vi-style)

Enter copy mode with `prefix + [`.

| Shortcut | Action |
|----------|--------|
| `v` | Begin selection |
| `Ctrl+v` | Toggle rectangle selection |
| `y` | Copy selection and exit |
| `q` | Exit copy mode |

## Mouse

Mouse support is enabled. Scrolling enters copy mode automatically.

| Action | Effect |
|--------|--------|
| Scroll up | Enter copy mode and scroll history |
| Drag to select | Select text (stays in copy mode) |
| Double-click | Select word |
| Triple-click | Select line |

## Vim-Tmux Navigator

These work seamlessly between Neovim and Tmux panes:

| Shortcut | Action |
|----------|--------|
| `Ctrl+h` | Move to left pane/split |
| `Ctrl+j` | Move to pane below |
| `Ctrl+k` | Move to pane above |
| `Ctrl+l` | Move to right pane/split |
| `Ctrl+\` | Move to previous pane |

## Standard Tmux

Not custom but commonly used:

| Shortcut | Action |
|----------|--------|
| `prefix + c` | New window |
| `prefix + n` | Next window |
| `prefix + p` | Previous window |
| `prefix + 1-9` | Switch to window by number |
| `prefix + w` | List windows |
| `prefix + d` | Detach session |
| `prefix + x` | Kill pane |
| `prefix + &` | Kill window |
| `prefix + z` | Toggle pane zoom |
| `prefix + ?` | Show all keybindings |

## Plugins

- **tmux-sensible** - Sensible defaults
- **vim-tmux-navigator** - Seamless navigation with Neovim
- **tmux-yank** - Enhanced copy/paste
- **tmux-which-key** - Shows available keybindings

Install plugins: `prefix + I` (capital I)
