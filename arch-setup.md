# Fresh arch install

# make sure package managers are up to date

sudo pacman -Syu
yay -Syu

# Install Github CLI and configure git so that you can get this file

sudo pacman -S github-cli
gh auth login

git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git config pull.rebase false

# clone the dotfiles repo

git clone git@github.com:kiwiscanfly/dotfiles.git

# install the essentials

```bash
sudo pacman -S sway \
	nemo \
	nautilus \
	waybar \
	wofi \
	ghostty \
	neovim \
	tmux \
	tree-sitter-cli \
	wl-clipboard \
	nsxiv \
	gimp \
	zenity

sudo pacman -S swaybg
```

# Install some widgets

yay -S eww-git swaylock-effects

# Install notification center

sudo pacman -S swaync

# Install and set up, our login manager

#this is for ly, a minimal login manager
# sudo pacman -S ly
# sudo systemctl disable gdm #this is for gnome
# sudo systemctl enable ly@tty2.service

# this was for the previous setup, I quite like the look of the one that comes with cinnamon so I'll keep that for now

sudo nvim /etc/lightdm/lightdm.conf

# edit the user-session value under the [Seat:*]

# the background can be changed in the /etc/lightdm/slick-greeter.conf

# Install Maple Mono Nerd Font from https://github.com/subframe7536/maple-font/releases

sudo mv MapleMono-NF /usr/share/fonts
sudo mv MapleMono /usr/share/fonts
fc-cache -f -v

```bash
ln -S ~/dotfiles/.config/sway/config ~/.config/sway/config
ln -s ~/dotfiles/.config/ghostty/config ~/.config/ghostty/config
ln -s ~/dotfiles/.config/ghostty/shaders ~/.config/ghostty/shaders
ln -s ~/dotfiles/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
ln -s ~/dotfiles/.config/swaylock/ ~/.config/swaylock
ln -s ~/dotfiles/.config/swaync/ ~/.config/swaync
ln -s ~/dotfiles/.config/waybar/ ~/.config/waybar
ln -s ~/dotfiles/.config/wofi/ ~/.config/wofi
ln -s ~/dotfiles/.config/eww/ ~/.config/eww
ln -s ~/dotfiles/.config/yazi ~/.config/yazi
ln -s ~/dotfiles/.Xresources ~/.Xresources
mkdir -p ~/.config/bat && ln -s ~/dotfiles/.config/bat/themes ~/.config/bat/themes && ln -s ~/dotfiles/.config/bat/config ~/.config/bat/config
bat cache --build
mkdir -p ~/.config/nsxiv && ln -s ~/dotfiles/.config/nsxiv/exec ~/.config/nsxiv/exec
```

```bash
yay -S nvm
echo $0
source /usr/share/nvm/init-nvm.sh
```

nvm install node
nvm use node

# If you need to restart waybar at any point run

killall waybar && waybar &

# Don't forget to copy wallpaper

sudo cp /home/rebecca/dotfiles/wallpaper.png /usr/share/backgrounds/

# Install Theme editor

```bash
yay themix-full-git
```

# Link the themes

```bash
ln -s ~/dotfiles/linux-themes/ ~/.themes/bex-codes
ln -sf ~/dotfiles/linux-themes/gtk-4.0/* ~/.config/gtk-4.0/
```

# Zsh Setup

## Install zsh and CLI tools

```bash
sudo pacman -S zsh \
    bat \
    eza \
    fd \
    fzf \
    git-delta \
    ripgrep \
    zoxide \
    starship \
    lazygit \
    figlet \
    lolcat \
    gum \
    jq \
    yq \
    direnv \
    htop \
    yazi
```

## Install antidote (zsh plugin manager)

```bash
yay -S zsh-antidote
```

## Set zsh as default shell

```bash
chsh -s /usr/bin/zsh
```

## Symlink zsh configs

```bash
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zsh_plugins.txt ~/.zsh_plugins.txt
ln -s ~/dotfiles/.config/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/scripts ~/scripts
```

## Symlink git config (for delta)

```bash
mkdir -p ~/.config/git
ln -s ~/dotfiles/.config/git/config ~/.config/git/config
ln -s ~/dotfiles/.config/git/delta-themes.gitconfig ~/.config/git/delta-themes.gitconfig
```

## Log out and back in for shell change to take effect

# Compile Cinnamon theme

```bash
sudo pacman -S sassc
sassc ~/dotfiles/linux-themes/cinnamon/scss/cinnamon.scss ~/dotfiles/linux-themes/cinnamon/cinnamon.css
```

# 1Password CLI

```bash
yay -S 1password-cli
op signin
```

# Music Player Setup (MPD + rmpc + cava)

## Install packages

```bash
sudo pacman -S mpd mpc cava aubio ffmpeg yt-dlp
yay -S rmpc
```

## Create MPD directories

```bash
mkdir -p ~/.config/mpd/playlists
```

## Symlink configs

```bash
ln -s ~/dotfiles/.mpdconf-linux ~/.config/mpd/mpd.conf
ln -sf ~/dotfiles/.config/rmpc/config-linux.ron ~/.config/rmpc/config.ron
ln -s ~/dotfiles/.config/rmpc/themes ~/.config/rmpc/themes
mkdir -p ~/.config/cava
ln -s ~/dotfiles/.config/cava/shaders ~/.config/cava/shaders
ln -s ~/dotfiles/.config/cava/themes ~/.config/cava/themes
ln -sf ~/dotfiles/.config/cava/config-linux ~/.config/cava/config
```

## Enable MPD user service

```bash
systemctl --user enable mpd
systemctl --user start mpd
```

## Update database

```bash
mpc update
```

## Run rmpc

```bash
rmpc
```

## Enable MPRIS support (for media widgets)

```bash
sudo pacman -S mpd-mpris playerctl
```

Symlink the service:
```bash
mkdir -p ~/.config/systemd/user
ln -s ~/dotfiles/.config/systemd/user/mpd-mpris.service ~/.config/systemd/user/mpd-mpris.service
systemctl --user enable mpd-mpris
systemctl --user start mpd-mpris
```

# Taskwarrior Setup

## Install taskwarrior

```bash
sudo pacman -S task
```

## Create local secrets file

```bash
nvim ~/.taskrc.local
```

Add (use same values as your other devices):
```
sync.server.client_id=YOUR-UUID
sync.encryption_secret=YOUR-SECRET
```

## Sync with server

```bash
task sync
```

Note: Don't use `task sync init` - data already exists on the server from another device.
