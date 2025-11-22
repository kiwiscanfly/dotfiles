# MPD + rmpc Music Player

This setup uses **[MPD](https://www.musicpd.org/)** (Music Player Daemon) as a headless music server with **[rmpc](https://github.com/mierak/rmpc)** as a modern Rust-based TUI client.

## Features

- Background music daemon managed by brew services
- Beautiful TUI interface with vim keybindings
- Album art support (via Ghostty's Kitty graphics protocol)
- Custom Bex Codes theme matching your dotfiles aesthetic
- Quick access via tmux keybinding: `prefix+t`
- Audio visualizer (cava) integration

## Music Library Location

`~/Music`

## Controls

```bash
# Start/stop MPD service
brew services start mpd
brew services stop mpd

# Launch rmpc client
rmpc

# Or use tmux keybinding
# In tmux: prefix+t (Ctrl+b, then t)

# Command-line controls with mpc
mpc update          # Update music database
mpc ls              # List all files
mpc listall         # List all songs
mpc play            # Play
mpc pause           # Pause
mpc next            # Next track
mpc prev            # Previous track
```

## Configuration Files

- MPD config: `.mpdconf` (symlinked by stow)
- rmpc config: `.config/rmpc/config.ron`
- rmpc theme: `.config/rmpc/themes/bex_codes.ron`

## First Time Setup

After installing via `brew bundle`, MPD will automatically:
1. Start as a background service
2. Scan `~/Music` for audio files
3. Create database at `~/.config/mpd/database`

The database updates automatically, but you can manually trigger updates with `mpc update`.

## Layout

The Queue tab features a split layout:
- **Top (70%)**: Queue (65%) and Album Art (35%) side-by-side
- **Bottom (30%)**: Audio visualizer (cava)

## Theme

The custom Bex Codes theme uses a Gruvbox-inspired color palette matching the rest of your dotfiles:
- Background: Ghostty dark background (#282828)
- Highlighted items: Muted green (#7d9d82)
- Currently playing: Muted blue (#6b7d9d)
- Borders: Purple (#7c6f9f)
- Visualizer: Muted green bars (#7d9d82)
