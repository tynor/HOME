PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
if [ "$(uname)" = Darwin -a -d "$HOME/Library/Python" ]; then
    for d in $HOME/Library/Python/*; do
        PATH="$d/bin:$PATH"
    done
fi
PATH="$HOME/.composer/vendor/bin:$PATH"
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
PATH="$HOME/.linkerd2/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="/usr/local/smlnj/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/bin:$PATH"
export PATH

if [ "$(uname)" = Darwin ]; then
    export DYLD_LIBRARY_PATH=$HOME/.local/lib
fi

export SELECTOR=fzy

export DOCKER_BUILDKIT=1

# Request ads be disabled
export ADBLOCK=1
export DISABLE_OPENCOLLECTIVE=1
