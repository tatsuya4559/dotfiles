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

-- alias for set option
local set = vim.o
local setlocal = vim.bo

-- alias for autocmd
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- alias for mapping
local function generate_mapfunc(mode, noremap)
  return function (before, after, ...)
    vim.keymap.set(mode, before, after, merge({ noremap = noremap }, ...))
  end
end

local map      = generate_mapfunc("", false)
local nmap     = generate_mapfunc("n", false)
local imap     = generate_mapfunc("i", false)
local nnoremap = generate_mapfunc("n", true)
local inoremap = generate_mapfunc("i", true)
local vnoremap = generate_mapfunc("v", true)
local tnoremap = generate_mapfunc("t", true)

local silent = { silent = true }

-- alias for command
local command = vim.api.nvim_create_user_command

-- options -------------------------------------------------
-- set.number = true

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
set.listchars = [[tab:▸ ,trail:·]]

set.undofile = true

set.nrformats = "bin,hex,unsigned"

vim.cmd "language C"

vim.cmd "colorscheme tokyonight"

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

-- autocmd -------------------------------------------------
local group_name = "MyVimrc"
augroup(group_name, { clear = true })

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
autocmd("FileType", {
  group = group_name,
  pattern = "go",
  callback = function()
    setlocal.tabstop = 4
    setlocal.shiftwidth = 4
    setlocal.expandtab = false
    vim.wo.listchars = "tab:  ,trail:·"
  end
})
autocmd("FileType", {
  group = group_name,
  pattern = "python",
  callback = function()
    setlocal.tabstop = 4
    setlocal.shiftwidth = 4
  end
})

-- copy to clipboard only when yanked
set.clipboard = ""
autocmd("TextYankPost", {
  group = group_name,
  pattern = "*",
  callback = function()
    if vim.v.event.operator == "y" then
      vim.fn.setreg("+", vim.fn.getreg(""))
    end
  end
})

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

-- keymaps -------------------------------------------------
-- disable dangerous keymaps
nnoremap("<f1>", "<nop>")
nnoremap("Q", "<nop>")
nnoremap("ZZ", "<nop>")
nnoremap("ZQ", "<nop>")

-- open vimrc
nnoremap("<leader>v", ":edit ~/.config/nvim/init.lua<cr>")
nnoremap("<leader>p", ":edit ~/.config/nvim/lua/plugins.lua<cr>")

-- utility
nnoremap("vv", "vg_")
vnoremap(".",  ":normal .<cr>")
nnoremap("Y", "y$")
nnoremap("<c-w>g", "<c-w>sgg")
nnoremap("yt", ":<c-u>tabedit %<cr>")
tnoremap("<c-w>", [[<c-\><c-n><c-w>]])
tnoremap("<esc><esc>", [[<c-\><c-n>]])

-- submode(https://zenn.dev/mattn/articles/83c2d4c7645faa)
-- out of work
--[[
vim.cmd [[
nmap zh zh<SID>z
nmap zl zl<SID>z
nnoremap <script> <SID>zh zh<SID>z
nnoremap <script> <SID>zl zl<SID>z
nmap <SID>z <Nop>
]]
--]]

-- lsp keymap
nnoremap("[d", vim.diagnostic.goto_prev, silent)
nnoremap("]d", vim.diagnostic.goto_next, silent)
nnoremap("<space>d", "<cmd>TroubleToggle<cr>")
nnoremap("ga", require("lspsaga.codeaction").code_action)
nnoremap("<f2>", require("lspsaga.rename").rename)

nnoremap("<c-s>", require("lspsaga.floaterm").open_float_terminal, silent)
tnoremap("<c-s>", [[<c-\><c-n>:lua require("lspsaga.floaterm").close_float_terminal()<cr>]], silent)
nnoremap("<space>t", function() require("lspsaga.floaterm").open_float_terminal("tig") end, silent)

local function on_hover()
  if vim.bo.filetype == "vim" then
    local cword = vim.fn.expand("<cword>")
    vim.cmd(string.format("help %s", cword))
  end
  vim.lsp.buf.hover()
end
nnoremap("K", on_hover)

-- telescope keymap
local telescope = require("telescope.builtin")
nnoremap("<c-p>", telescope.git_files)
nnoremap("<space>ff", telescope.find_files)
nnoremap("<space>b", telescope.buffers)
nnoremap("<space>g", telescope.live_grep)

nnoremap("gd",  telescope.lsp_definitions)
nnoremap("gr", telescope.lsp_references)
nnoremap("gi", telescope.lsp_implementations)
nnoremap("go", telescope.lsp_document_symbols)
nnoremap("gs", telescope.lsp_dynamic_workspace_symbols)

-- luasnip keymap
vim.cmd [[
imap <expr> <tab> luasnip#expandable() ? '<plug>luasnip-expand-snippet' : '<tab>'
imap <c-j> <plug>luasnip-jump-next
imap <c-k> <plug>luasnip-jump-prev
]]

-- nvim-tree keymap
nnoremap("<space>e", "<cmd>NvimTreeToggle<cr>")

-- toggleterm keymap
nnoremap("<c-j>", "<cmd>ToggleTerm<cr>", silent)

-- quickrun keymap
nmap("<leader>r", "<plug>(quickrun)")

-- git-blame keymap
nnoremap("<leader>b", "<cmd>GitBlameToggle<cr>")

-- asterisk keymap
map("*", "<plug>(asterisk-z*)")
map("#", "<plug>(asterisk-z#)")

-- gina keymap
nnoremap("<leader>gh", ":<c-u>Gina browse --exact : <cr>")
vnoremap("<leader>gh", ":Gina browse --exact : <cr>")
nnoremap("<leader>gy", ':<c-u>Gina browse --exact --yank :<cr>:let @+ = @"<cr>')
vnoremap("<leader>gy", ':Gina browse --exact --yank : <cr>:let @+ = @"<cr>')

-- commands ------------------------------------------------
vim.cmd [[
command! SepLineFeed :s/\\n/\r/g
command! -range AlignTable :<line1>,<line2>!pandoc -t gfm
]]

-- copy path
vim.cmd [[
command! CopyPath :let @+ = expand('%')
command! CopyFullPath :let @+ = expand('%:p')
]]

-- neotest
local neotest = require("neotest")
command("NeoTestFile", function() neotest.run.run(vim.fn.expand("%")) end, {})
command("NeoTestNearest", function() neotest.run.run() end, {})
command("NeoTestOutput", function() neotest.output.open() end, {})
command("NeoTestSummaryToggle", function() neotest.summary.toggle() end, {})

------------------------------------------------------------
local dap = require("dap")
nnoremap("<leader>db", dap.toggle_breakpoint)
nnoremap("<f5>", dap.continue)
nnoremap("<f10>", dap.step_over)
nnoremap("<f11>", dap.step_into)
nnoremap("<f12>", dap.step_out)
