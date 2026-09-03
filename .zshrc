# Only run this file for interactive shells
[[ $- != *i* ]] && return

[[ -f "$HOME/.zsh-pre.local" ]] && . "$HOME/.zsh-pre.local"
: ${use_vcs_info:=1}

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
compinit -u

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

if [[ -d "/opt/workbrew/bin" ]]; then
    eval $(/opt/workbrew/bin/brew shellenv)
elif [[ -d "/opt/homebrew/bin" ]]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi

[[ -d "$HOME/Applications/MacVim.app/Contents/bin" ]] && path=("$HOME/Applications/MacVim.app/Contents/bin" $path)

[[ -d "$HOME/.opencode/bin" ]] && path=("$HOME/.opencode/bin" $path)

[[ -d "/Library/Frameworks/Python.framework/Versions/Current/bin" ]] && path=("/Library/Frameworks/Python.framework/Versions/Current/bin" $path)
[[ -d "/opt/podman/bin" ]] && path=("/opt/podman/bin" $path)
[[ -d "$HOME/.local/google-cloud-sdk/bin" ]] && path=("$HOME/.local/google-cloud-sdk/bin" $path)
[[ -d "/usr/local/go/bin" ]] && path=("/usr/local/go/bin" $path)
[[ -d "$HOME/go/bin" ]] && path=("$HOME/go/bin" $path)
[[ -d "$HOME/.cargo/bin" ]] && path=("$HOME/.cargo/bin" $path)

[[ -d "$HOME/.usr/bin" ]] && path=("$HOME/.usr/bin" "$HOME/.usr/sbin" $path)
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
[[ -d "$HOME/bin" ]] && path=("$HOME/bin" $path)

export PATH

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

if command -v pyenv >/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init - zsh)"
fi

export SELECTOR=fzy

export DOCKER_BUILDKIT=1

# Request ads be disabled
export ADBLOCK=1
export DISABLE_OPENCOLLECTIVE=1

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

export LSCOLORS='ExGxBxDxCxEgEdxbxgxcxd'
export CLICOLOR=1

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
    if [[ $use_vcs_info -eq 1 ]]; then
        vcs_info
    else
        vcs_info_msg_0_=""
    fi
}

if [ "$(uname)" = Darwin ]; then
    clear_quarantine() {
        xattr -r -d com.apple.quarantine "$@"
    }
fi

# Placate my muscle memory for vi
alias vi=vim

# Alias defined for working with the ~/.dotfiles repository
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias ssh-add-keychain='ssh-add --apple-load-keychain'

if command -v gpg >/dev/null 2>&1; then
    export GPG_TTY="$(tty)"
fi

# Notetaking

# Open the daily log note
l() {
    local f="$HOME/notes/log/Log $(date -I).txt"
    mkdir -p "$(dirname "$f")"
    if [ ! -s "$f" ]; then
        echo "# Log $(date -I)" >"$f"
    fi
    $EDITOR "$f"
}

todo() {
    mkdir -p "$HOME/notes"
    $EDITOR "$HOME/notes/todo.txt"
}

globdir() {
    (
        set -e
        cd "$1"
        fs=(*(N))
        if (( $#fs > 0 )); then
            find ${fs[@]} -depth 0 -type "$2"
        fi
    )
}

# Open a project note
proj() {
    local p_base="$HOME/notes/projects"
    mkdir -p "$p_base"
    local p_name="$(globdir "$p_base" d | fzy)"
    if [ -z "$p_name" ]; then
        echo "No project selected; exiting" >&2
        return 1
    fi
    local p_path="$p_base/$p_name"
    mkdir -p "$p_path"
    local n_name="$(globdir "$p_path" f | fzy)"
    if [ -z "$n_name" ]; then
        echo "No file selected; exiting" >&2
        return 1
    fi
    local n_path="$p_path/$n_name"
    mkdir -p "$(dirname "$n_path")"
    $EDITOR "$n_path"
}

# pnpm
export PNPM_HOME="/Users/tynor/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
