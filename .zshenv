PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
if [ "$(uname)" = Darwin ]; then
    PATH="$HOME/Library/Python/3.7/bin:$PATH"
fi
PATH="$HOME/.composer/vendor/bin:$PATH"
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
PATH="$HOME/.linkerd2/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/bin:$PATH"
export PATH

if [ "$(uname)" = Darwin ]; then
    export DYLD_LIBRARY_PATH=$HOME/.local/lib
fi

export GOPRIVATE=go.lockr.io/inf,go.lockr.io/lockr
