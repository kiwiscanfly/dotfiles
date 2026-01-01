# Zsh Keyboard Shortcuts

## Navigation

| Shortcut | Action |
|----------|--------|
| `Ctrl+A` | Move to beginning of line |
| `Ctrl+E` | Move to end of line |
| `Home` | Move to beginning of line |
| `End` | Move to end of line |
| `Ctrl+B` | Move backward one character |
| `Ctrl+F` | Move forward one character |
| `Alt+B` | Move backward one word |
| `Alt+F` | Move forward one word |
| `Alt+Left` | Move backward one word |
| `Alt+Right` | Move forward one word |
| `Ctrl+Left` | Move backward one word |
| `Ctrl+Right` | Move forward one word |

## Editing

| Shortcut | Action |
|----------|--------|
| `Ctrl+X Ctrl+E` | Edit current command in $EDITOR (nvim) |
| `Ctrl+D` | Delete character under cursor (or exit if empty) |
| `Delete` | Delete character under cursor |
| `Ctrl+H` | Backspace |
| `Ctrl+U` | Delete from cursor to beginning of line |
| `Ctrl+K` | Delete from cursor to end of line |
| `Ctrl+W` | Delete word before cursor |
| `Alt+D` | Delete word after cursor |
| `Alt+Backspace` | Delete word before cursor |
| `Ctrl+Y` | Yank (paste) last killed text |
| `Ctrl+T` | Transpose characters |
| `Alt+T` | Transpose words |
| `Alt+U` | Uppercase word |
| `Alt+L` | Lowercase word |
| `Alt+C` | Capitalize word |
| `Ctrl+_` | Undo |
| `Ctrl+/` | Undo (alternative) |

## Shell Control

| Shortcut | Action |
|----------|--------|
| `Ctrl+L` | Clear screen |
| `Ctrl+C` | Cancel current command |
| `Ctrl+Z` | Suspend current process |
| `Ctrl+D` | Exit shell (if line empty) |
| `Alt+.` | Insert last argument from previous command |
| `!!` | Repeat last command (type, not shortcut) |

## History

| Shortcut | Action |
|----------|--------|
| `Up` | Search history backward (matches current input) |
| `Down` | Search history forward (matches current input) |
| `Ctrl+R` | FZF fuzzy history search |

## Autosuggestions

| Shortcut | Action |
|----------|--------|
| `Ctrl+Space` | Accept autosuggestion |
| `Right` | Accept autosuggestion (default) |

## FZF Integration

| Shortcut | Action |
|----------|--------|
| `Ctrl+T` | Fuzzy find files (with bat preview) |
| `Ctrl+R` | Fuzzy search command history |
| `Alt+C` | Fuzzy find and cd to directory (with eza tree preview) |

## Custom Functions

| Command | Action |
|---------|--------|
| `rgf <pattern>` | Interactive ripgrep with fzf and bat preview |
| `gcb` | Git checkout branch with fzf |
| `fkill` | Fuzzy kill process |
