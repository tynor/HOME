vim9script

b:ale_linters = ['ruff', 'pyright']

b:ale_fixers = ['ruff_format']

setlocal textwidth=72
setlocal formatoptions-=t
setlocal formatoptions+=cnq
