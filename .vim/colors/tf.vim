set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "tf"

hi Normal           ctermfg=NONE        ctermbg=NONE
hi NonText          ctermfg=darkgrey

hi Cursor           ctermfg=black       ctermbg=white       cterm=reverse
hi CursorLine       ctermbg=234  cterm=NONE
hi LineNr           ctermfg=darkgray

hi VertSplit        ctermfg=lightgrey   ctermbg=black
hi StatusLine       ctermfg=white       ctermbg=darkgray cterm=NONE
hi StatusLineNC     ctermfg=lightgrey   ctermbg=black cterm=NONE

hi Visual           ctermfg=NONE ctermbg=236

hi SpecialKey       ctermfg=NONE        ctermbg=NONE        cterm=NONE

" Syntax groups

" Reduce syntax noise
hi Operator         ctermfg=NONE      cterm=NONE
hi Keyword          ctermfg=NONE      cterm=NONE
hi Number           ctermfg=NONE      cterm=NONE
hi Character        ctermfg=NONE      cterm=NONE
hi String           ctermfg=NONE      cterm=NONE
hi Type             ctermfg=NONE      cterm=NONE
hi Identifier       ctermfg=NONE      cterm=NONE
hi PreProc          ctermfg=NONE      cterm=NONE
hi Structure        ctermfg=NONE      cterm=NONE
hi Special          ctermfg=NONE      cterm=NONE
hi Statement        ctermfg=NONE      cterm=NONE
hi Conditional      ctermfg=NONE      cterm=NONE
hi Label            ctermfg=NONE      cterm=NONE
hi Repeat           ctermfg=NONE      cterm=NONE
hi Constant         ctermfg=NONE      cterm=NONE

hi Comment          ctermfg=darkgrey  cterm=NONE

hi Todo             ctermfg=yellow    cterm=NONE
