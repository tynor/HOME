vim9script

import autoload "tf.vim"

augroup vimrc
  autocmd!

  # Return to last edit position when opening files
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
  # Reset for git commit messages
  autocmd BufReadPost COMMIT_EDITMSG execute "normal gg0"

  # Reload files changed outside vim
  autocmd FocusGained,BufEnter *
        \ if getcmdwintype() ==# '' |
        \   checktime |
        \ endif

  # Trim trailing whitespace on save
  autocmd BufWritePre *.py,*.js,*.ts,*.rs,*.go,*.c,*.h,*.vim
        \ call tf.TrimTrailingWhitespace()

  # Create parent directories on write
  autocmd BufWritePre * call tf.MkdirParent(expand('<afile>:p:h'))
augroup END
