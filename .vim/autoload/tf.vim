vim9script

export def TrimTrailingWhitespace(): void
  var view = winsaveview()
  silent! keeppatterns :%s/\s\+$//e
  winrestview(view)
enddef

export def MkdirParent(dir: string): void
  if empty(dir)
    return
  endif

  if !isdirectory(dir)
    mkdir(dir, 'p')
  endif
enddef

export def EditPrefix(): string
  var prefix = expand('%:h')
  if prefix == ''
    return './'
  else
    return $'{prefix}/'
  endif
enddef

def FzyPrefix(prefix: string, command: string): void
  var clean_prefix = substitute(prefix, '\/\+$', '', '')
  var selection: string
  try
    selection = system($'cd {clean_prefix} && rg --files --hidden | fzy')
  catch /Vim:Interrupt/
    redraw!
    return
  endtry
  redraw!
  if v:shell_error == 0 && !empty(selection)
    exec $'{command} {clean_prefix}/{selection}'
  endif
enddef

export def FzyCwd(command: string): void
  FzyPrefix('.', command)
enddef

export def FzyFileDir(command: string): void
  var prefix = expand('%:h')
  FzyPrefix(prefix, command)
enddef

# C compiler flags handling for ALE

export def ClangCflags(): string
  var start = expand('%:p:h')
  if empty(start)
    start = getcwd()
  endif

  var script = findfile('clang-cflags.sh', $'{start};')

  if empty(script)
    return ''
  endif

  var dir = fnamemodify(script, ':p:h')
  var file = fnamemodify(script, ':t')

  return system($'cd {shellescape(dir)} && sh {shellescape(file)}')
enddef
