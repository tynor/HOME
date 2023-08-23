vim.cmd[[
  syntax off
  colorscheme tf
]]

vim.g.mapleader = ' '

vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.switchbuf = 'useopen'
vim.o.winwidth = 80
vim.o.backspace = 'indent,eol'
vim.o.wildmode = 'longest,list'
vim.o.statusline = '%<%f %y %-4(%m%)%=%-19(%3l,%02c%03V%)'
vim.o.mouse = false
vim.o.guicursor = ''

local agid = vim.api.nvim_create_augroup('vimrc', {clear=false})
vim.api.nvim_create_autocmd('FileType', {
  group = agid,
  pattern = 'lua',
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})
vim.api.nvim_create_autocmd('BufReadPost', {
  group = agid,
  callback = function(ev)
    if ev.event == 'COMMIT_EDITMSG' then
      return
    end
    local prev_line = vim.fn.line[['"]]
    local end_line = vim.fn.line[[$]]
    if prev_line > 0 and prev_line <= end_line then
      local first_vis = vim.fn.line[[w0]]
      local last_vis = vim.fn.line[[w$]]
      if end_line - prev_line > ((last_vis - first_vis) / 2) - 1 then
        vim.cmd[[normal! g`"zz]]
      else
        vim.cmd[[normal! g`"]]
      end
    end
  end
})

vim.keymap.set('n', 'Y', 'yy')
vim.keymap.set('n', '<leader><leader>', '<c-^>')
