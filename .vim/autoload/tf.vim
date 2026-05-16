function! tf#trim_trailing_whitespace() abort
  let l:view = winsaveview()
  silent! keeppatterns %s/\s\+$//e
  call winrestview(l:view)
endfunction

function! tf#mkdir_parent(dir) abort
  if empty(a:dir)
    return
  endif

  if !isdirectory(a:dir)
    call mkdir(a:dir, 'p')
  endif
endfunction

function! tf#edit_prefix() abort
  let l:prefix = expand('%:h')
  if l:prefix == ''
    return './'
  else
    return l:prefix . '/'
  endif
endfunction

function! tf#fzy_prefix(prefix, command)
  let l:prefix = substitute(a:prefix, '\/\+$', '', '')
  try
    let selection = system('cd ' . l:prefix . ' && rg --files --hidden | fzy')
  catch /Vim:Interrupt/
    redraw!
    return
  endtry
  redraw!
  if v:shell_error == 0 && !empty(selection)
    exec a:command . ' ' . l:prefix . '/' .selection
  endif
endfunction

function! tf#fzy_cwd(command)
  call tf#fzy_prefix('.', a:command)
endfunction

function! tf#fzy_file_dir(command)
  let l:prefix = expand('%:h')
  call tf#fzy_prefix(l:prefix, a:command)
endfunction
