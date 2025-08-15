# ================================================================================
# Zsh Configuration - Optimized and Organized
# ================================================================================

# --------------------------------------------------------------------------------
# Early Initialization (Must come first)
# --------------------------------------------------------------------------------

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --------------------------------------------------------------------------------
# Environment Variables
# --------------------------------------------------------------------------------

# Oh My Zsh path
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration
ZSH_THEME="powerlevel10k/powerlevel10k"

# Path configuration (consolidated and ordered by priority)
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/anaconda3/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

# Language and locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Default editor
export EDITOR='nano'

# History configuration
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export HIST_STAMPS="yyyy-mm-dd"

# --------------------------------------------------------------------------------
# Oh My Zsh Configuration
# --------------------------------------------------------------------------------

# Performance optimizations
DISABLE_UNTRACKED_FILES_DIRTY="true"  # Faster git status in large repos
COMPLETION_WAITING_DOTS="true"        # Visual feedback during completion

# Auto-update configuration
zstyle ':omz:update' mode reminder    # Remind to update
zstyle ':omz:update' frequency 7      # Check weekly

# Plugins (ordered by importance/frequency of use)
plugins=(
  git              # Git aliases and functions
  flutter          # Flutter development
  npm              # NPM completions
  nvm              # Node version manager
  1password        # 1Password CLI
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# --------------------------------------------------------------------------------
# Shell Options
# --------------------------------------------------------------------------------

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

# Better defaults
alias ls="colorls --group-directories-first"
alias ll="colorls -la --group-directories-first"
alias la="colorls -A --group-directories-first"

# Git shortcuts
alias gs="git status"
alias gp="git pull"
alias gco="git checkout"
alias gb="git branch"
alias glog="git log --oneline --graph --decorate"

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

# --------------------------------------------------------------------------------
# Key Bindings
# --------------------------------------------------------------------------------

# Word navigation (Option + Arrow keys on macOS)
bindkey "[D" backward-word
bindkey "[C" forward-word
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

# Docker completions
fpath=(/Users/rebecca/.docker/completions $fpath)

# Dart CLI completions
[[ -f /Users/rebecca/.dart-cli-completion/zsh-config.zsh ]] && \
  source /Users/rebecca/.dart-cli-completion/zsh-config.zsh || true

# Initialize completions
autoload -Uz compinit
compinit -C  # Skip security check for faster startup

# Completion options
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# --------------------------------------------------------------------------------
# External Tools & Plugins
# --------------------------------------------------------------------------------

# Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Syntax highlighting (load after completions)
source /Users/rebecca/.zsh-stuff/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Auto-suggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept  # Ctrl+Space to accept suggestion

# NVM lazy loading for faster startup
nvm() {
  unset -f nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  nvm "$@"
}

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