# Zsh Configuration

~/dotfiles/scripts/welcome.sh

# --------------------------------------------------------------------------------
# Environment Variables
# --------------------------------------------------------------------------------

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Path configuration (consolidated and ordered by priority)
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

# Language and locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Default editor
export EDITOR='nvim'

# bat configuration
export BAT_THEME="Catppuccin Mocha"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# History configuration
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export HIST_STAMPS="yyyy-mm-dd"

# --------------------------------------------------------------------------------
# Completion System
# --------------------------------------------------------------------------------

# Add completion paths
fpath=(/Users/rebecca/.docker/completions $fpath)

# Initialize completion system
autoload -Uz compinit
compinit

# --------------------------------------------------------------------------------
# Prompt - Starship
# --------------------------------------------------------------------------------

# Initialize Starship prompt
eval "$(starship init zsh)"

# --------------------------------------------------------------------------------
# Shell Options
# --------------------------------------------------------------------------------

# Word navigation characters - exclude / and other delimiters for path-aware navigation
# This makes Alt+Arrow stop at slashes in paths like ~/repos/shiny
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

setopt HIST_IGNORE_DUPS     # Don't record duplicate commands
setopt HIST_IGNORE_SPACE    # Don't record commands starting with space
setopt HIST_REDUCE_BLANKS   # Remove extra blanks from commands
setopt SHARE_HISTORY        # Share history between sessions
setopt AUTO_CD              # CD into directory by typing its name
setopt AUTO_PUSHD           # Make cd push old directory onto stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates onto directory stack
setopt CORRECT              # Command correction
setopt COMPLETE_IN_WORD     # Complete from cursor position
setopt GLOB_COMPLETE        # Generate completions for globs
setopt EXTENDED_GLOB        # Extended globbing patterns
setopt NO_BEEP              # Disable beep on error

# --------------------------------------------------------------------------------
# Aliases
# --------------------------------------------------------------------------------

# Flutter/Dart aliases
alias flutter="fvm flutter"
alias dart="fvm dart"
alias snapp_cli="fvm exec snapp_cli"

# Better defaults with eza
alias ls="eza --group-directories-first --icons"
alias ll="eza -la --group-directories-first --icons --git"
alias la="eza -A --group-directories-first --icons"
alias lt="eza --tree --level=2 --icons --ignore-glob='node_modules|.git'"

# Eza colors - purple theme
export EZA_COLORS="di=1;35:ex=38;5;217:ln=38;5;140:*.md=38;5;183:*.txt=38;5;219:*.json=38;5;222:*.js=38;5;180:*.py=38;5;151:*.css=38;5;183:*.html=38;5;210"

# Git shortcuts
alias gs="git status"
alias gp="git pull"
alias gco="git checkout"
alias gb="git branch"
alias gd="git diff"
alias glog="git log --oneline --graph --decorate"
alias lg="lazygit"

# Directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"

# Safety nets
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias mkdir="mkdir -pv"

# Utilities
alias path='echo -e ${PATH//:/\\n}'
alias welcome='~/dotfiles/scripts/welcome.sh'

# bat - better cat with syntax highlighting
alias cat='bat --style=plain --paging=never'
alias ccat='/bin/cat'  # Original cat if needed

# Markdown viewer
alias mdv='glow'

# Pretty print structured data
alias pretty-json='jq -C . | bat -l json'
alias pretty-yaml='yq -C . | bat -l yaml'
alias pretty-xml='yq -p xml -C . | bat -l xml'
alias pretty-csv='column -t -s, | bat -l csv'

# macOS specific
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# --------------------------------------------------------------------------------
# Functions
# --------------------------------------------------------------------------------

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract any archive type (removed - conflicts with OMZ extract plugin if loaded)

# Find process by name
findprocess() {
  ps aux | grep -v grep | grep "$1"
}

# Quick backup of a file
backup() {
  cp "$1" "$1.backup-$(date +%Y%m%d-%H%M%S)"
}

# Show disk usage of current directory
duh() {
  du -sh * | sort -hr
}

# Interactive ripgrep with fzf and bat preview
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  local file
  file=$(rg --hidden --files-with-matches --no-messages "$1" | fzf --preview "bat --color=always --style=numbers --line-range=:500 {} | rg --hidden --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --hidden --ignore-case --pretty --context 10 '$1' {}")
  [ -n "$file" ] && ${EDITOR:-nvim} "$file"
}

# Fuzzy git branch checkout
fgb() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Fuzzy process kill
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Yazi file manager with directory changing capability
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# --------------------------------------------------------------------------------
# Key Bindings
# --------------------------------------------------------------------------------

# Word navigation (Option + Arrow keys on macOS)
bindkey "^[[1;3C" forward-word      # Alt+Right
bindkey "^[[1;3D" backward-word     # Alt+Left
bindkey "^[[1;5C" forward-word      # Ctrl+Right
bindkey "^[[1;5D" backward-word     # Ctrl+Left
bindkey "^[[H" beginning-of-line    # Home key
bindkey "^[[F" end-of-line          # End key
bindkey "^[[3~" delete-char         # Delete key

# History search
bindkey "^[[A" history-search-backward  # Up arrow
bindkey "^[[B" history-search-forward   # Down arrow

# --------------------------------------------------------------------------------
# Completions
# --------------------------------------------------------------------------------

# Dart CLI completions
[[ -f /Users/rebecca/.dart-cli-completion/zsh-config.zsh ]] && \
  source /Users/rebecca/.dart-cli-completion/zsh-config.zsh || true

# Completion options
zstyle ':completion:*' menu select                                       # Enable menu selection
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'               # Case insensitive matching
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"                 # Colorize completions using LS_COLORS
zstyle ':completion:*:descriptions' format '%B%d%b'                     # Bold format for completion group descriptions
zstyle ':completion:*:warnings' format 'No matches for: %d'             # Message when no completions found
zstyle ':completion:*' group-name ''                                    # Group completions by type
zstyle ':completion:*:default' list-prompt '%S%M matches%s'             # Show match count in completion list

# --------------------------------------------------------------------------------
# Antidote Plugin Manager
# --------------------------------------------------------------------------------

# Configure NVM (before loading plugins)
export NVM_AUTO_USE=true  # Automatically switch Node versions with .nvmrc files

# Initialize Antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# Load plugins from .zsh_plugins.txt
antidote load

# Configure zsh-autosuggestions (loaded by Antidote)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7c6f9f" # Subtle purple matching theme
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept  # Ctrl+Space to accept suggestion

# --------------------------------------------------------------------------------
# Local Configuration (optional)
# --------------------------------------------------------------------------------

# Source local configuration if it exists
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# --------------------------------------------------------------------------------
# Performance Monitoring (optional - comment out if not needed)
# --------------------------------------------------------------------------------

# Uncomment to debug slow startup
# zmodload zsh/zprof  # Add at the top of file
# zprof  # Add at the bottom of file
# FZF setup (fuzzy finder)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# FZF + fd integration (faster, respects .gitignore)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# FZF colors - purple theme matching lualine
export FZF_DEFAULT_OPTS="--color=fg:#f5c2e7,bg:#4d3d52,hl:#cba6f7 \
--color=fg+:#f5c2e7,bg+:#7c6f9f,hl+:#cba6f7 \
--color=info:#85c4b8,prompt:#d99368,pointer:#cba6f7 \
--color=marker:#99d1a0,spinner:#85c4b8,header:#7d9dcc"

# FZF preview with bat
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always {}'"

# Direnv hook (auto-load environment variables)
eval "$(direnv hook zsh)"

# Zoxide configuration
export _ZO_ECHO=1                      # Print matched directory before navigating
export _ZO_RESOLVE_SYMLINKS=1          # Resolve symlinks when storing paths
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --preview 'eza --tree --level=2 --color=always {}'"

# Zoxide (smarter cd)
eval "$(zoxide init zsh)"
