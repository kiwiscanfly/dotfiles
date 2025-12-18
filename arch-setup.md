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
	wl-clipboard

sudo pacman -S swaybg
```

# Instal some widgets

yay -S eww-git swaylock-effects

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
ln -s ~/dotfiles/.config/waybar/ ~/.config/waybar
ln -s ~/dotfiles/.config/wofi/ ~/.config/wofi
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

