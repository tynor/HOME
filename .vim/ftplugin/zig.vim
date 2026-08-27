vim9script

b:ale_fixers = [
  'remove_trailing_lines',
  'trim_whitespace',
  'zigfmt',
]

b:ale_linters = ['zls']

setlocal textwidth=72
setlocal formatoptions-=t
setlocal formatoptions+=cnq
