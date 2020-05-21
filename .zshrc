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
    if [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
        hook_com[misc]='?'
    else
        hook_com[misc]=''
    fi
}

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

PS1='%F{g}%m%f:%1~ ${vcs_info_msg_0_}$ '

setopt AUTO_PUSHD
setopt PUSHD_SILENT

export LSCOLORS='ExGxBxDxCxEgEdxbxgxcxd'
export CLICOLOR=1

unset command_not_found_handle

export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

export EDITOR=vi
set -o emacs

export WORDCHARS='*?[]~&;:$%^<>'

autoload -U compinit
compinit

mcd() {
    mkdir -p "$1" && cd "$1"
}

ng() {
    git init "$1" && cd "$1"
}

tmp() {
    cd $(mktemp -d)
}

unsetopt flowcontrol

print_pem_bundle() {
    openssl crl2pkcs7 -nocrl -certfile "$1" |
    openssl pkcs7 -print_certs -text -noout |
    grep 'Subject:'
}

docker_image_sha256() {
    docker inspect -f '{{index .RepoDigests 0}}' "$1" | head -1
}

if [ "$(uname)" = Linux ]; then
    alias ls='ls --color=always'
fi

if [ -f "$HOME/.local/iterm2_shell_integration.zsh" ]; then
    . "$HOME/.local/iterm2_shell_integration.zsh"
fi

find_closest_gitdir() {
    local search="$PWD"
    while true; do
        if [ "$search" = / ]; then
            return
        fi
        if [ -d "$search/.git" ]; then
            echo "$search"
            return
        fi
        search="$(dirname "$search")"
    done
}

iterm2_set_status() {
    if which it2setkeylabel &>/dev/null; then
        local gitdir="$(find_closest_gitdir)"
        if [[ $gitdir = $HOME* ]]; then
            gitdir="~${gitdir#"$HOME"}"
        fi
        it2setkeylabel set status "$gitdir"
    fi
}

precmd() {
    vcs_info
}

chpwd() {
    iterm2_set_status
}

iterm2_set_status
