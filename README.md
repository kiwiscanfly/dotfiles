# Dotfiles

My personal configuration files managed with GNU Stow.

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
