vim.cmd[[
  syntax off
  colorscheme tf
]]

vim.g.mapleader = ' '

local o = vim.o

o.showmatch = true
o.ignorecase = true
o.smartcase = true
o.cursorline = true
o.switchbuf = 'useopen'
o.winwidth = 80
o.backspace = 'indent,eol'
o.wildmode = 'longest,list'
o.statusline = '%<%f %y %-4(%m%)%=%-19(%3l,%02c%03V%)'
o.mouse = ''
o.mousescroll = 'ver:0,hor:0'
o.guicursor = ''

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
    local fn = vim.fn
    local prev_line = fn.line[['"]]
    local end_line = fn.line[[$]]
    if prev_line > 0 and prev_line <= end_line then
      local first_vis = fn.line[[w0]]
      local last_vis = fn.line[[w$]]
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

local function strip_char(s, c)
  while s:sub(-1) == c do
    s = s:sub(1, -2)
  end
  return s
end

local function fzy_prefix(prefix, f)
  local cmd = 'cd ' .. prefix .. ' && rg --files --hidden | fzy'
  local output = vim.fn.system(cmd)
  if vim.v.shell_error == 0 and output:len() > 0 then
    f(prefix .. '/' .. strip_char(output, '\n'))
  end
end

local function fzy(f)
  fzy_prefix('.', f)
end

local function fzy_file_dir(f)
  fzy_prefix(strip_char(prefix, '/'), f)
end

local function edit_file(name)
  vim.cmd('edit ' .. name)
end

vim.keymap.set('n', '<leader>ff', function() fzy(edit_file) end)
