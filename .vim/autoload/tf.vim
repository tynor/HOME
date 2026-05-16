function g:tf#ExecFlags(name)
  let l:p = expand('%:p:h')
  while l:p !=# '/' && l:p !=# ''
    let l:filepath = l:p . '/' . a:name
    if filereadable(l:filepath)
      return trim(system(shellescape(l:filepath))) . ' -Wno-undefined-internal'
    endif
    if isdirectory(l:p . '/.git')
      return ''
    endif
    let l:p = fnamemodify(l:p, ':h')
  endwhile

  return ''
endfunction

function g:tf#CClangFlags()
  let l:flags = g:tf#ExecFlags('clang-cflags.sh')
  return trim(l:flags . ' -Wno-undefined-internal')
endfunction

function g:tf#ObjcClangFlags()
  let l:flags = g:tf#ExecFlags('clang-cflags.sh')
  let l:flags = l:flags . ' ' . g:tf#ExecFlags('clang-objcflags.sh')
  return trim(l:flags . ' -Wno-undefined-internal')
endfunction

function g:tf#CxxClangFlags()
  let l:flags = g:tf#ExecFlags('clang-cxxflags.sh')
  return trim(l:flags . ' -Wno-undefined-internal')
endfunction

function g:tf#ObjcxxClangFlags()
  let l:flags = g:tf#ExecFlags('clang-cxxflags.sh')
  let l:flags = l:flags . ' ' . g:tf#ExecFlags('clang-objcflags.sh')
  return trim(l:flags . ' -Wno-undefined-internal')
endfunction

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
  call tf#fzy_prefix('.', command)
endfunction

function! tf#fzy_file_dir(command)
  let l:prefix = expand('%:h')
  call tf#fzy_prefix(l:prefix, command)
endfunction
