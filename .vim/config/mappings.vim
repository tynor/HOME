" Mappings follow the given conventions:
"
" <leader>a - code navigation (ALE)
" <leader>d - diagnostics (ALE)
" <leader>f - file navigation

" Clear search highlight
nnoremap <leader>c :nohlsearch\|pclose<cr>

" Preserve cursor position on line join
nnoremap J mzJ`z

" Insert the current directory into the command window
cnoremap <expr> %% tf#edit_prefix()

" Quickly switch to the previous file
nnoremap <leader><space> <c-^>

" Insert a hash rocket
" This comes up less now that I don't work in PHP as much.
" However it's so engrained in my muscle memory that on the occation I
" do want it, it needs to be bound.
inoremap <c-l> <space>=><space>

" Code navigation

nnoremap <leader>ag <Plug>(ale_go_to_definition)
nnoremap <leader>ar <Plug>(ale_find_references)

" File navigation

nnoremap <leader>ff :call tf#fzy_cwd(':e')<cr>
nnoremap <leader>fd :call tf#fzy_file_dir(':e')<cr>

" ALE diagnostics

nnoremap <leader>dp <Plug>(ale_previous_wrap)
nnoremap <leader>dn <Plug>(ale_next_wrap)
