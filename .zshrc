# Only run this file for interactive shells
[[ $- != *i* ]] && return

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
unsetopt FLOW_CONTROL

unset command_not_found_handle

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true

export WORDCHARS='*?[]~&;:$%^<>'

autoload -Uz colors
colors

setopt PROMPT_SUBST

autoload -U vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' formats '(%F{g}%b%f%F{r}%c%u%m%f) '
zstyle ':vcs_info:*' actionformats '(%F{g}%b%f%F{r}%c%u%m%f|%a) '
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
    if git ls-files --others --exclude-standard -z | grep -qz .; then
        hook_com[misc]='?'
    else
        hook_com[misc]=''
    fi
}

PROMPT='%F{g}%m%f:%1~ ${vcs_info_msg_0_}%# '
RPROMPT='%(?..%F{red}exit %?%f)'

bindkey -e
bindkey '^R' history-incremental-search-backward

export EDITOR=vim
export VISUAL=$EDITOR

[[ -d "/opt/homebrew/bin" ]] && path=("/opt/homebrew/bin" "/opt/homebrew/sbin" $path)

[[ -d "/Library/Frameworks/Python.framework/Versions/Current/bin" ]] && path=("/Library/Frameworks/Python.framework/Versions/Current/bin" $path)
[[ -d "/opt/podman/bin" ]] && path=("/opt/podman/bin" $path)
[[ -d "/usr/local/go/bin" ]] && path=("/usr/local/go/bin" $path)
[[ -d "$HOME/go/bin" ]] && path=("$HOME/go/bin" $path)
[[ -d "$HOME/.cargo/bin" ]] && path=("$HOME/.cargo/bin" $path)
export PNPM_HOME="$HOME/Library/pnpm"
[[ -d "$PNPM_HOME" ]] && path=("$PNPM_HOME" $path)

[[ -d "$HOME/.usr/bin" ]] && path=("$HOME/.usr/bin" "$HOME/.usr/sbin" $path)
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
[[ -d "$HOME/bin" ]] && path=("$HOME/bin" $path)

export PATH

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

export SELECTOR=fzy

export DOCKER_BUILDKIT=1

# Request ads be disabled
export ADBLOCK=1
export DISABLE_OPENCOLLECTIVE=1

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

export LSCOLORS='ExGxBxDxCxEgEdxbxgxcxd'

mcd() {
    mkdir -p "$1" && cd "$1"
}

ng() {
    git init "$1" && cd "$1"
}

tmp() {
    cd $(mktemp -d)
}

precmd() {
    vcs_info
}

if [ "$(uname)" = Darwin ]; then
    clear_quarantine() {
        xattr -r -d com.apple.quarantine "$@"
    }
fi

# Alias defined for working with the ~/.dotfiles repository
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias ssh-add-keychain='ssh-add --apple-load-keychain'

if command -v gpg >/dev/null 2>&1; then
    export GPG_TTY="$(tty)"
fi
