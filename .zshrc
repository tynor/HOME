setopt PROMPT_SUBST

autoload -U vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' formats '(%F{g}%b%f%F{r}%u%c%m%f) '
zstyle ':vcs_info:*' actionformats '(%F{g}%b%f%F{r}%u%c%m%f|%a) '
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        hook_com[misc]='?'
    else
        hook_com[misc]=''
    fi
}

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

export PS1='%F{g}%m%f:%1~ ${vcs_info_msg_0_}$ '

PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
PATH="$HOME/Library/Python/3.7/bin:$PATH"
PATH="$HOME/.composer/vendor/bin:$PATH"
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/bin:$PATH"
export PATH

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

tmp() {
    cd $(mktemp -d)
}

unsetopt flowcontrol

print_pem_bundle() {
    openssl crl2pkcs7 -nocrl -certfile "$1" |
    openssl pkcs7 -print_certs -text -noout |
    grep 'Subject:'
}

export GOPRIVATE=go.lockr.io/inf,go.lockr.io/lockr

if [ "$(uname)" = Linux ]; then
    alias ls='ls --color=always'
fi

precmd() {
    vcs_info
}
