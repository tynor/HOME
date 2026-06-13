vim9script

import autoload "tf.vim"

# Mappings follow the given conventions:
#
# <leader>a - code navigation (ALE)
# <leader>d - diagnostics (ALE)
# <leader>f - file navigation

# Clear search highlight
nnoremap <leader>c :nohlsearch\|pclose<cr>

# Insert the current directory into the command window
cnoremap <expr> %% tf.EditPrefix()

# Quickly switch to the previous file
nnoremap <leader><leader> <c-^>

# Insert a hash rocket
# This comes up less now that I don't work in PHP as much.
# However it's so engrained in my muscle memory that on the occation I
# do want it, it needs to be bound.
inoremap <c-l> <space>=><space>

# Code navigation

nnoremap <leader>ag <Plug>(ale_go_to_definition)
nnoremap <leader>ar <Plug>(ale_find_references)

# File navigation

nnoremap <leader>ff <ScriptCmd>tf.FzyCwd(':e')<cr>
nnoremap <leader>fd <ScriptCmd>tf.FzyFileDir(':e')<cr>

# ALE diagnostics

nnoremap <leader>dp <Plug>(ale_previous_wrap)
nnoremap <leader>dn <Plug>(ale_next_wrap)
