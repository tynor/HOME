def RenameFile(): void
  let old_name = expand('%')
  let new_name = input('New file name: ', old_name, 'file')
  if new_name != '' && new_name != old_name
    exec ':Move ' . new_name
    redraw!
  endif
enddef
