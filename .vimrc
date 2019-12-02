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
set re=1
set t_Co=256
set background=dark
set statusline=%<%f\ %y\ %-4(%m%)%=%-19(%3l,%02c%03V%)

color tf

augroup vimrc
  autocmd!

  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

imap <c-l> <space>=><space>
imap <c-c> <esc>
nnoremap <leader><leader> <c-^>
cnoremap <expr> %% expand('%:h').'/'
nmap <leader>c :noh<cr>

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', old_name, 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
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
