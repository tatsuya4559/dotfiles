-- utils ---------------------------------------------------
local function merge(table1, ...)
  if ... == nil then
    return table1
  end
  for _, t in ipairs(...) do
    for k, v in pairs(t) do
      table1[k] = v
    end
  end
  return table1
end

-- keymap --------------------------------------------------

local function generate_mapfunc(mode, noremap)
  return function (before, after, ...)
    vim.keymap.set(mode, before, after, merge({ noremap = noremap }, ...))
  end
end
local map      = generate_mapfunc("", false)
local nmap     = generate_mapfunc("n", false)
local nnoremap = generate_mapfunc("n", true)
local inoremap = generate_mapfunc("i", true)
local vnoremap = generate_mapfunc("v", true)
local tnoremap = generate_mapfunc("t", true)

local silent = { silent = true }

nnoremap("<f1>", "<nop>")
nnoremap("Q", "<nop>")
nnoremap("ZZ", "<nop>")
nnoremap("ZQ", "<nop>")

nnoremap("<leader>v", ":edit ~/.config/nvim/init.lua<cr>")
nnoremap("<leader>p", ":edit ~/.config/nvim/lua/plugins.lua<cr>")
nnoremap("vv", "vg_")
tnoremap("<c-w>", [[<c-\><c-n><c-w>]])
vnoremap(".",  ":normal .<cr>")
nnoremap("Y", "y$")
-- nnoremap("<c-w>-", ":<c-u>sp %:h<cr>")
nnoremap("<c-w>g", "<c-w>sgg")
tnoremap("<esc><esc>", [[<c-\><c-n>]])
nnoremap("yt", ":<c-u>tabedit %<cr>")

nnoremap("<leader>s", [[:!tmux popup -w90\% -h90\% -d '\#{pane_current_path}' -E<cr>]])
nnoremap("<space>t", ":!tig status<cr>")

-- submode(https://zenn.dev/mattn/articles/83c2d4c7645faa)
-- out of work
-- vim.cmd [[
-- nmap zh zh<SID>z
-- nmap zl zl<SID>z
-- nnoremap <script> <SID>zh zh<SID>z
-- nnoremap <script> <SID>zl zl<SID>z
-- nmap <SID>z <Nop>
-- ]]

-- lsp keymap
nnoremap("<space>e", vim.diagnostic.open_float, silent)
nnoremap("[g", vim.diagnostic.goto_prev, silent)
nnoremap("]g", vim.diagnostic.goto_next, silent)
nnoremap("<space>d", "<cmd>TroubleToggle<cr>")

nnoremap("K", vim.lsp.buf.hover)
nnoremap("gd",  vim.lsp.buf.definition, silent)
nnoremap("<space>rn", vim.lsp.buf.rename, silent)
nnoremap("<space>a", vim.lsp.buf.code_action, silent)
nnoremap("gr", vim.lsp.buf.references, silent)

-- telescope keymap
local telescope = require("telescope.builtin")
nnoremap("<c-p>", telescope.git_files)
nnoremap("<space>ff", telescope.find_files)
nnoremap("<space>b", telescope.buffers)
nnoremap("<space>g", telescope.live_grep)

-- nvim-tree keymap
nnoremap("<leader>t", "<cmd>NvimTreeToggle<cr>")

-- toggleterm keymap
nnoremap("<c-j>", "<cmd>ToggleTerm<cr>", silent)
inoremap("<c-j>", "<esc><cmd>ToggleTerm<cr>", silent)

-- quickrun keymap
nmap("<leader>r", "<plug>(quickrun)")

-- git-blame keymap
nnoremap("<leader>b", "<cmd>GitBlameToggle<cr>")

-- asterisk keymap
map("*", "<plug>(asterisk-z*)")
map("#", "<plug>(asterisk-z#)")

-- gina keymap
nnoremap("<leader>gh", ":<c-u>Gina browse --exact : <cr>", silent)
vnoremap("<leader>gh", ":Gina browse --exact : <cr>", silent)
nnoremap("<leader>gy", ':<c-u>Gina browse --exact --yank :<cr>:let @+ = @"<cr>', silent)
vnoremap("<leader>gy", ':Gina browse --exact --yank : <cr>:let @+ = @"<cr>', silent)


-- options -------------------------------------------------
local set = vim.o
local setlocal = vim.bo
-- set.number = true
vim.g.python3_host_prog = "/usr/bin/python3"

set.wrap = false

set.swapfile = false

set.expandtab = true
set.tabstop = 2
set.shiftwidth = 2

set.clipboard = "unnamedplus,unnamed"

set.termguicolors = true

set.smartindent = true
set.breakindent = true

set.ignorecase = true
set.smartcase = true

set.list = true
set.listchars = [[tab:▸\ ,trail:-]]

set.undofile = true

set.nrformats = "bin,hex,unsigned"

vim.cmd "language C"

-- autocmd -------------------------------------------------
local group_name = "MyVimrc"
local autocmd = vim.api.nvim_create_autocmd
vim.api.nvim_create_augroup(group_name, { clear = true })

autocmd("BufWritePost", {
  group = group_name,
  pattern = "plugins.lua",
  callback = function()
    vim.cmd "source <afile> | PackerSync"
  end
})

autocmd("TermEnter", {
  group = group_name,
  pattern = "term://*toggleterm#*",
  callback = function()
    tnoremap("<c-j>", "<cmd>ToggleTerm<cr>", silent)
  end
})

autocmd({ "FocusGained", "BufEnter" }, {
  group = group_name,
  pattern = "*",
  callback = function()
    vim.cmd "checktime"
  end
})

autocmd("FileType", {
  group = group_name,
  pattern = "yaml",
  callback = function()
    setlocal.lisp = true
  end
})

vim.cmd [[
function! Copy_unnamed_to_plus(opr)
  if a:opr ==# 'y'
    let @+ = @"
  endif
endfunction
set clipboard=
autocmd MyVimrc TextYankPost * call Copy_unnamed_to_plus(v:event.operator)
]]

-- auto mkdir
vim.cmd [[
function! s:auto_mkdir(dir) abort
  if !isdirectory(a:dir) &&
        \ input(printf('"%s" does not exist. Should it be created? (y/N)', a:dir)) =~? '^y\%[es]$'
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyVimrc BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))
]]

-- quickfix
vim.cmd [[
function! s:toggle_quickfix()
  let l:nr = winnr('$')
  cwindow
  let l:nr2 = winnr('$')
  if l:nr == l:nr2
    cclose
  endif
endfunction
nnoremap <silent><script> <space>q :<c-u>call <SID>toggle_quickfix()<cr>
nnoremap <silent> ]q :<c-u>cn<cr>
nnoremap <silent> [q :<c-u>cp<cr>
autocmd MyVimrc QuickFixCmdPost *grep* cwindow
packadd! cfilter
]]


vim.cmd [[
command! SepLineFeed :s/\\n/\r/g
command! -range AlignTable :<line1>,<line2>!pandoc -t gfm
]]

vim.cmd [[
iabbrev improt import
iabbrev flase false
iabbrev Flase False
iabbrev apn1 ap-northeast-1
iabbrev apn2 ap-northeast-2
iabbrev apn3 ap-northeast-3
iabbrev use1 us-east-1
iabbrev use2 us-east-2
]]

-- copy path
vim.cmd [[
command! CopyPath :let @+ = expand('%')
command! CopyFullPath :let @+ = expand('%:p')
]]

------------------------------------------------------------


vim.cmd "colorscheme tokyonight"
