# ================================================================================
# Zsh Configuration - Optimized and Organized
# ================================================================================

# --------------------------------------------------------------------------------
# Early Initialization (Must come first)
# --------------------------------------------------------------------------------

~/dotfiles/scripts/welcome.sh

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

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

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
export EDITOR='nvim'

# bat configuration
export BAT_THEME="Catppuccin-Mocha"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

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

# Add completion paths before loading Oh My Zsh
fpath=(/Users/rebecca/.docker/completions $fpath)

# Plugins (ordered by importance/frequency of use)
plugins=(
  git              # Git aliases and functions
  fzf-tab          # FZF-powered tab completion
  aws              # AWS CLI completions and shortcuts
  docker           # Docker completions
  docker-compose   # Docker Compose completions
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

# Better defaults with eza
alias ls="eza --group-directories-first --icons"
alias ll="eza -la --group-directories-first --icons --git"
alias la="eza -A --group-directories-first --icons"
alias lt="eza --tree --level=2 --icons --ignore-glob='node_modules|.git'"

# Cute eza colors
export EZA_COLORS="di=1;35:ex=1;33:ln=1;36:*.md=1;36:*.txt=37:*.json=1;33:*.js=33:*.py=32:*.css=35:*.html=1;31"

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

# Quick command help
alias help='tldr'

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

# Fuzzy cd with fd and eza preview
fcd() {
  local dir
  dir=$(fd --type d --hidden --follow --exclude .git | fzf --preview 'eza --tree --level=2 --color=always {}') && cd "$dir"
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

# Dart CLI completions
[[ -f /Users/rebecca/.dart-cli-completion/zsh-config.zsh ]] && \
  source /Users/rebecca/.dart-cli-completion/zsh-config.zsh || true

# Completion options (Oh My Zsh already initialized compinit)
zstyle ':completion:*' menu no                                           # Disable traditional menu completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'               # Case insensitive matching
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"                 # Colorize completions using LS_COLORS
zstyle ':completion:*:descriptions' format '%B%d%b'                     # Bold format for completion group descriptions
zstyle ':completion:*:warnings' format 'No matches for: %d'             # Message when no completions found
zstyle ':completion:*' group-name ''                                    # Group completions by type
zstyle ':completion:*:default' list-prompt '%S%M matches%s'             # Show match count in completion list

# FZF-tab configuration
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --level=2 --color=always $realpath'  # Show directory contents with eza
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0                          # Add padding to fzf popup window
zstyle ':fzf-tab:*' switch-group '<' '>'                                # Use < and > to switch between completion groups
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup                          # Use tmux popup for fzf interface

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

# Load NVM path immediately
export NVM_DIR="$HOME/.nvm"
export PATH="$NVM_DIR/versions/node/$(cat $NVM_DIR/alias/default 2>/dev/null)/bin:$PATH"

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

# FZF preview with bat
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always {}'"

# Direnv hook (auto-load environment variables)
eval "$(direnv hook zsh)"
