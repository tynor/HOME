set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "tf"

hi Normal        guifg=NONE guibg=NONE ctermfg=NONE        ctermbg=NONE
hi NonText       guifg=darkgrey ctermfg=darkgrey

hi Cursor        gui=reverse guifg=black guibg=white ctermfg=black       ctermbg=white       cterm=reverse
hi CursorLine    guibg=#1c1c1c ctermbg=234  cterm=NONE
hi LineNr        guifg=darkgrey ctermfg=darkgray

hi VertSplit     guifg=lightgrey guibg=black ctermfg=lightgrey   ctermbg=black
hi StatusLine    guifg=white guibg=darkgrey ctermfg=white       ctermbg=darkgray cterm=NONE
hi StatusLineNC  guifg=darkgrey guibg=lightgrey ctermfg=lightgrey   ctermbg=black cterm=NONE

hi Visual        guifg=NONE guibg=#303030 ctermfg=NONE ctermbg=236
hi Pmenu         guifg=NONE guibg=NONE ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi PmenuSel      guifg=NONE guibg=darkgrey ctermfg=NONE        ctermbg=darkgrey    cterm=NONE
hi PmenuSbar     guifg=black guibg=white ctermfg=black       ctermbg=white       cterm=NONE

hi SpecialKey    guifg=NONE guibg=NONE ctermfg=NONE        ctermbg=NONE        cterm=NONE

" Folds
hi Folded        guifg=NONE guibg=darkgrey ctermfg=NONE   ctermbg=darkgrey        cterm=NONE
hi FoldColumn    guifg=NONE guibg=NONE ctermfg=NONE   ctermbg=NONE        cterm=NONE

" Syntax groups

" Reduce syntax noise
hi Operator         guifg=NONE ctermfg=NONE      cterm=NONE
hi Keyword          guifg=NONE ctermfg=NONE      cterm=NONE
hi Number           guifg=NONE ctermfg=NONE      cterm=NONE
hi Character        guifg=NONE ctermfg=NONE      cterm=NONE
hi String           guifg=NONE ctermfg=NONE      cterm=NONE
hi Type             guifg=NONE ctermfg=NONE      cterm=NONE
hi Identifier       guifg=NONE ctermfg=NONE      cterm=NONE
hi PreProc          guifg=NONE ctermfg=NONE      cterm=NONE
hi Structure        guifg=NONE ctermfg=NONE      cterm=NONE
hi Special          guifg=NONE ctermfg=NONE      cterm=NONE
hi Statement        guifg=NONE ctermfg=NONE      cterm=NONE
hi Conditional      guifg=NONE ctermfg=NONE      cterm=NONE
hi Label            guifg=NONE ctermfg=NONE      cterm=NONE
hi Repeat           guifg=NONE ctermfg=NONE      cterm=NONE
hi Constant         guifg=NONE ctermfg=NONE      cterm=NONE

hi cErrInParen      guifg=NONE ctermbg=NONE      ctermfg=NONE      cterm=NONE

hi Comment          guifg=darkgrey ctermfg=darkgrey  cterm=NONE

hi Todo             guifg=yellow guibg=NONE ctermfg=yellow  ctermbg=NONE  cterm=NONE

" ALE

hi ALEErrorSign guifg=darkgrey guibg=red ctermfg=darkgrey ctermbg=red
hi ALEWarningSign guifg=darkgrey guibg=yellow ctermfg=darkgrey ctermbg=yellow
