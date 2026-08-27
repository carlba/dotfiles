# =============================================================================
# Environment
# =============================================================================

export EDITOR="nvim"
export BAT_THEME="Visual Studio Dark+"

# use emacs keybindings in bash (default is vi)
bindkey -e

# =============================================================================
# Secrets
# =============================================================================

[[ -f ~/.secrets ]] && source ~/.secrets


# =============================================================================
# Plugins (Antidote)
# =============================================================================

if command -v brew >/dev/null; then
  source "$(brew --prefix)/share/antidote/antidote.zsh"
elif test -d /usr/share/zsh-antidote/antidote.zsh; then
  source /usr/share/zsh-antidote/antidote.zsh
else
  source ~/.antidote/antidote.zsh
fi

antidote load < ~/.zsh_plugins.txt


# =============================================================================
# History
# =============================================================================

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY


# =============================================================================
# Appearance
# =============================================================================

export LS_COLORS="$(vivid generate dark-plus)"


# =============================================================================
# Completion (Needs to happen before tools eval)
# =============================================================================

fpath=(${XDG_DATA_HOME:-$HOME/.local/share}/mise-completions/zsh $fpath)
# Created by (roles/common/files/mise/config.toml)
fpath=(~/.local/share/zsh/completions $fpath)

autoload -Uz compinit
compinit

# Better completion UI.
zstyle ':completion:*' menu select

# Case-insensitive completion.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Prefer Makefile targets over filenames.
zstyle ':completion:*:*:make:*' tag-order targets


# =============================================================================
# Tools
# =============================================================================
if [[ -f "$HOME/.local/bin/mise" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi

if command -v brew >/dev/null; then
  eval "$(mise activate zsh)"
fi

if command -v dua &> /dev/null; then
  eval "$(dua completions zsh)"
fi

if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# =============================================================================
# Aliases and Functions
# =============================================================================

[[ -f ~/.aliases.zsh ]] && source ~/.aliases.zsh
[[ -f ~/.functions.zsh ]] && source ~/.functions.zsh


# =============================================================================
# GhostTTY
# =============================================================================

if [[ -z "$TMUX" ]]; then
  if [[ $GHOSTTY == "1" ]]; then
      tmuxp load -y cada
  fi
fi
