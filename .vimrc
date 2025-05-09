" ex: ts=2 sts=2 sw=2 et:

set nocompatible

let mapleader=","

set hidden
set history=10000
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase
set cursorline
set cmdheight=1
set switchbuf=useopen
set winwidth=79
set t_ti= t_te=
set backspace=indent,eol
set showcmd
filetype plugin indent on
set wildmode=longest,list
set wildmenu
set modeline
set modelines=3
set timeout timeoutlen=1000 ttimeoutlen=100
set nojoinspaces
set autoread
set re=2
set t_Co=256
set background=dark
set statusline=%<%f\ %y\ %-4(%m%)%=%-19(%3l,%02c%03V%)

syntax on
color tf

augroup vimrc
  autocmd!

  autocmd FileType gitconfig setl noet
  autocmd FileType go setl noet
  autocmd FileType haskell setl ts=2 sts=2 sw=2 et
  autocmd FileType mlb setl ts=2 sts=2 sw=2 et
  autocmd FileType php setl ai
  autocmd FileType proto setl ts=2 sts=2 sw=2 et
  autocmd FileType purescript setl ts=2 sts=2 sw=2 et
  autocmd FileType yaml setl ts=2 sts=2 sw=2 et
  autocmd FileType python setl fdm=indent fdo-=search

  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  autocmd BufReadPost COMMIT_EDITMSG exec "normal gg0"
augroup END

function! EditPrefix()
  let l:prefix = expand('%:h')
  if l:prefix == ''
    return './'
  else
    return l:prefix . '/'
  endif
endfunction

imap <c-l> <space>=><space>
imap <c-c> <esc>
nnoremap <leader><leader> <c-^>
cnoremap <expr> %% EditPrefix()
nmap <leader>c :noh\|pc<cr>

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', old_name, 'file')
  if new_name != '' && new_name != old_name
    exec ':Move ' . new_name
    redraw!
  endif
endfunction
nmap <leader>n :call RenameFile()<cr>

function! Fzy(command)
  call FzyPrefix('.', a:command)
endfunction

function! FzyPrefix(prefix, command)
  let prefix = substitute(a:prefix, '\/\+$', '', '')
  try
    let selection = system('cd ' . prefix . ' && rg --files --hidden | fzy')
  catch /Vim:Interrupt/
    redraw!
    return
  endtry
  redraw!
  if v:shell_error == 0 && !empty(selection)
    exec a:command . ' ' . prefix . '/' . selection
  endif
endfunction

function! FzyFileDir(command)
  let prefix = expand('%:h')
  call FzyPrefix(prefix, a:command)
endfunction

nmap <leader>t :call Fzy(':e')<cr>
nmap <leader>w :call FzyFileDir(':e')<cr>
nmap <leader>e :e %%

function! TSServerPath()
  if $TSSERVER_BIN != ''
    return ' --tsserver-path ' . $TSSERVER_BIN
  endif
  return ''
endfunction

let g:haskell_indent_if = 2
let g:haskell_indent_before_where = 2

set omnifunc=ale#completion#OmniFunc

let g:ale_completion_enabled = 1

nnoremap <leader>gg :ALEGoToDefinition<cr>
nnoremap <leader>gf :ALEFix<cr>
nnoremap <leader>gc :pc<cr>
