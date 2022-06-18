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
local nmap     = generate_mapfunc("n", false)
local nnoremap = generate_mapfunc("n", true)
local inoremap = generate_mapfunc("i", true)
local vnoremap = generate_mapfunc("v", true)
local tnoremap = generate_mapfunc("t", true)

nnoremap("<leader>v", ":edit ~/.config/nvim/init.lua<cr>")
nnoremap("<leader>p", ":edit ~/.config/nvim/lua/plugins.lua<cr>")
nnoremap("vv", "vg_")
tnoremap("<c-w>", [[<c-\><c-n><c-w>]])
vnoremap(".",  ":normal .<cr>")
nnoremap("Y", "y$")
-- nnoremap <c-w>- :<c-u>sp %:h<cr>
nnoremap("<c-w>g", "<c-w>sgg")
tnoremap("<esc><esc>", [[<c-\><c-n>]])
nnoremap("yt", ":<c-u>tabedit %<cr>")

-- submode(https://zenn.dev/mattn/articles/83c2d4c7645faa)
-- not working in neovim
-- nmap("zh", "zh<SID>z")
-- nmap("zl", "zl<SID>z")
-- nnoremap("<script> <SID>zh", "zh<SID>z")
-- nnoremap("<script> <SID>zl", "zl<SID>z")
-- nmap("<SID>z", "<Nop>")


-- lsp keymap
local silent = { silent = true }
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


-- options -------------------------------------------------
local set = vim.o
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

vim.cmd "language C"

-- autocmd -------------------------------------------------
local group_name = "MyVimrc"
vim.api.nvim_create_augroup(group_name, { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = group_name,
  pattern = "plugins.lua",
  callback = function()
    vim.cmd "source <afile> | PackerSync"
  end
})

vim.api.nvim_create_autocmd("TermEnter", {
  group = group_name,
  pattern = "term://*toggleterm#*",
  callback = function()
    tnoremap("<c-j>", "<cmd>ToggleTerm<cr>", silent)
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

------------------------------------------------------------


vim.cmd "colorscheme tokyonight"
