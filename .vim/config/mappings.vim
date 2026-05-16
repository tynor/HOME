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
