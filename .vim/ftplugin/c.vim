vim9script

import autoload "tf.vim"

b:ale_linters = ['cc', 'clangd']
var cc_options = tf.ClangCflags()
b:ale_c_cc_options = cc_options
b:ale_c_clangd_options = cc_options

setlocal textwidth=72
setlocal formatoptions-=t
setlocal formatoptions+=cnq
