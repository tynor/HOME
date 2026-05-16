set encoding=utf-8
set fileencoding=utf-8

set hidden
set autoread
set confirm
set nobackup
set nowritebackup

if has('persistent_undo')
  set undofile
  set undodir^=~/.vim/undo//
endif

set ignorecase
set smartcase
set incsearch
set hlsearch

set autoindent
set backspace=indent,eol

set switchbuf=useopen

set wildmenu
set wildmode=longest:full,full
set completeopt=menuone,noselect

set splitright
set winwidth=79

set scrolloff=3

set timeout
set timeoutlen=500
set ttimeoutlen=10

set diffopt+=vertical
set diffopt+=algorithm:patience

" Use ALE for <c-x><x-o> completion
set omnifunc=ale#completion#OmniFunc
