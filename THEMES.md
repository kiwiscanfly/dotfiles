# Bex Codes Themes

This repository includes custom **Bex Codes** themes with a unified color palette across multiple applications.

## Color Palette

The Bex Codes theme uses a consistent muted Gruvbox-inspired palette:

### Primary Colors
- **Background:** `#282828` (Gruvbox dark)
- **Secondary Background:** `#4d3d52` (purple-gray)
- **Foreground:** `#e0e0e0` (light text)
- **Dark Foreground:** `#3c3836` (dark brown)

### Accent Colors
- **Purple:** `#7c6f9f` (medium)
- **Light Purple:** `#cba6f7` (keywords)
- **Blue:** `#6b7d9d` / `#7d9dcc` (muted / bright)
- **Aqua:** `#6b8c85` / `#85c4b8` (muted / bright)
- **Green:** `#7d9d82` / `#99d1a0` (muted / bright)
- **Orange:** `#a8826b` / `#d99368` (muted / bright)
- **Yellow:** `#a89d82` / `#d9c9a0` (muted / bright)
- **Red/Pink:** `#f38ba8`

## Applications

### Terminal & Shell

#### Ghostty
- **Base Theme:** Catppuccin Mocha
- **Background Override:** `#282828` (Gruvbox dark)
- **Cursor Effects:** Animated GLSL shaders (warp, ripple, blaze)
- **Config:** `.config/ghostty/config`

#### Starship Prompt
- **Style:** Rainbow powerline segments
- **Palette:** Custom muted Gruvbox colors
- **Features:** OS icon, git status, language versions, Docker context, time, vim mode
- **Config:** `.config/starship.toml`

#### Tmux
- **Style:** Rainbow statusline with powerline separators
- **Features:** Prefix indicator, window status highlighting
- **Active Window:** Yellow (`#d9c9a0`)
- **Inactive Windows:** Blue (`#7d9dcc`)
- **Borders:** Purple (`#7c6f9f`) / Orange (`#d99368`)
- **Config:** `.config/tmux/tmux.conf`

### Editors & Development

#### Neovim
- **Plugin:** lualine.nvim
- **Style:** Rainbow theme matching Starship and Tmux
- **Config:** `.config/nvim/lua/plugins/lualine.lua`

#### VSCode
- **Theme:** Bex Codes (local development extension)
- **Extension ID:** `local.bex-codes-theme`
- **Source:** Custom theme based on Catppuccin → Bex Codes mapping

#### Xcode
- **Themes:** Bex Codes (dark) and Bex Codes Light
- **Location:** `Library/Developer/Xcode/UserData/FontAndColorThemes/`

#### Sublime Text
- **Theme:** Bex Codes configuration
- **Config:** `Library/Application Support/Sublime Text/Packages/User/`

### CLI Tools

#### bat (Syntax Highlighting)
- **Theme:** Bex Codes
- **File:** `.config/bat/themes/Bex-Codes.tmTheme`
- **Enable:** Run `bat cache --build` after symlinking

#### Git Delta
- **Theme:** Bex Codes (custom feature)
- **Syntax Highlighting:** Uses Bex Codes bat theme
- **Diff Colors:** Custom backgrounds for added/removed lines (dark green/red)
- **UI Colors:** Purple borders, blue file headers, yellow line numbers
- **Config Files:**
  - `.config/git/delta-themes.gitconfig` - Bex Codes theme definition
  - `~/.gitconfig` - Includes delta-themes.gitconfig and uses `features = bex-codes`

#### yazi (File Manager)
- **Theme:** Rainbow configuration
- **Config:** `.config/yazi/`

#### lazygit (Git TUI)
- **Theme:** Custom Bex Codes with muted Gruvbox palette
- **Config:** `.config/lazygit/config.yml`
- **Note:** On macOS, requires manual symlink to `~/Library/Application Support/lazygit/config.yml` (see Installation Notes)

#### rmpc (Music Player Client)
- **Theme:** Custom Bex Codes with muted Gruvbox palette
- **File:** `.config/rmpc/themes/bex_codes.ron`
- **Features:** Matches terminal color scheme, custom progress bars, syntax highlighting

#### toot (Mastodon CLI/TUI)
- **Theme:** Custom Bex Codes with muted Gruvbox palette
- **Config:** `.config/toot/settings.toml`
- **Features:** 256-color mode, custom palette with purple UI elements, yellow highlights, green accents
- **TUI Mode:** Launch with `toot tui` for full-screen interface

### Other Applications

#### Drafts
- **Themes:** Bex Codes (dark) and Bex Codes Light
- **Location:** `Library/Application Support/Drafts/Themes/`

## Color Mapping Reference

### Catppuccin Mocha → Bex Codes

This mapping shows how Catppuccin Mocha colors are translated to the Bex Codes palette:

#### Background/UI
| Catppuccin Mocha | Color | Bex Codes | Color | Purpose |
|------------------|-------|-----------|-------|---------|
| base | `#1e1e2e` | base | `#1e1e2e` | Background |
| surface0 | `#313244` | dark purple | `#4d3d52` | Line highlight |
| surface1 | `#45475a` | medium purple | `#7c6f9f` | Active guide |
| overlay0 | `#7f849c` | medium purple | `#7c6f9f` | Gutter foreground |
| overlay2 | `#9399b2` | medium purple | `#7c6f9f` | Overlay |
| subtext0 | `#a6adc8` | subtext | `#a6adc8` | Secondary text |

#### Foreground/Text
| Catppuccin Mocha | Color | Bex Codes | Color | Purpose |
|------------------|-------|-----------|-------|---------|
| text | `#cdd6f4` | light text | `#e0e0e0` | Foreground |
| rosewater | `#f5e0dc` | yellow | `#d9c9a0` | Caret |

#### Syntax Colors
| Catppuccin Mocha | Color | Bex Codes | Color | Purpose |
|------------------|-------|-----------|-------|---------|
| red | `#f38ba8` | pink/red | `#f38ba8` | Errors |
| peach | `#fab387` | orange | `#d99368` | Numbers |
| yellow | `#f9e2af` | yellow | `#d9c9a0` | Warnings |
| green | `#a6e3a1` | green | `#99d1a0` | Strings |
| teal | `#94e2d5` | aqua | `#85c4b8` | Operators |
| sky | `#89dceb` | aqua | `#85c4b8` | Operators |
| sapphire | `#74c7ec` | blue | `#7d9dcc` | Properties |
| blue | `#89b4fa` | blue | `#7d9dcc` | Functions |
| lavender | `#b4befe` | blue | `#7d9dcc` | Variables |
| mauve | `#cba6f7` | light purple | `#cba6f7` | Keywords |
| pink | `#f5c2e7` | pink | `#f5c2e7` | Special |
| flamingo | `#f2cdcd` | yellow | `#d9c9a0` | Special |
| maroon | `#eba0ac` | pink/red | `#f38ba8` | Errors |

### Design Philosophy

**Key Principle:** Group similar colors together; don't create new distinctions the original theme didn't have.

- **Purples consolidate** to medium purple (`#7c6f9f`) for UI elements
- **Blues consolidate** to muted blue (`#7d9dcc`) for syntax
- **Aqua/Teal consolidate** to aqua (`#85c4b8`) for operators
- **Reds/Pinks consolidate** to pink/red (`#f38ba8`) for errors
- **Yellows** use warm yellow (`#d9c9a0`) throughout
- **Greens** use muted green (`#99d1a0`) for strings

This creates a **cohesive, unified aesthetic** across all tools while maintaining clear syntax differentiation.

## Installation Notes

1. **Ghostty:** Theme automatically applied via config
2. **Starship:** Theme automatically applied via config
3. **Tmux:** Theme automatically applied via config
4. **Neovim:** Theme automatically applied via lazy.nvim
5. **VSCode:** Bex Codes theme must be installed separately (local extension)
6. **bat:** Run `bat cache --build` after symlinking dotfiles
7. **Git Delta:** Theme automatically applied via included `.config/git/delta-themes.gitconfig` (ensure `~/.gitconfig` includes this file)
8. **yazi:** Theme automatically applied via config
9. **lazygit:** Requires manual symlink on macOS (see README step 8)
10. **rmpc:** Theme automatically applied via config
11. **toot:** Theme automatically applied via config
12. **Xcode/Drafts/Sublime:** Manual installation required
