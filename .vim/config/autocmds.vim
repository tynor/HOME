augroup vimrc
  autocmd!

  " Return to last edit position when opening files
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
  " Reset for git commit messages
  autocmd BufReadPost COMMIT_EDITMSG execute "normal gg0"

  " Reload files changed outside vim
  autocmd FocusGained,BufEnter * checktime

  " Trim trailing whitespace on save
  autocmd BufWritePre *.py,*.js,*.ts,*.rs,*.go,*.c,*.h,*.vim
        \ call tf#trim_trailing_whitespace()

  " Create parent directories on write
  autocmd BufWritePre * call tf#mkdir_parent(expand('<afile>:p:h'))
augroup END
