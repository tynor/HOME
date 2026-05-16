set showcmd
set showmode

set cursorline

set cmdheight=1
set modeline
set modelines=3
set statusline=%<%f\ %y\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set laststatus=2

set linebreak

" By default do not hard-wrap.
set textwidth=0

set termguicolors

set shortmess+=c

set wildignore+=*.o,*.obj,*.pyc,*.class
set wildignore+=*/.git/*,*/node_modules/*,*/dist/*,*/build/*
