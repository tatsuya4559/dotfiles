vim.cmd [[
nnoremap <leader>r :source $MYVIMRC<cr>
nnoremap <leader>v :e $MYVIMRC<cr>
colorscheme tokyonight
iabbrev improt import
iabbrev flase false
iabbrev Flase False
iabbrev apn1x ap-northeast-1
iabbrev apn3x ap-northeast-3
iabbrev use1x us-east-1
command! CopyPath :let @+ = expand('%')
command! CopyFullPath :let @+ = expand('%:p')
]]

vim.o.number = false
vim.o.wrap = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.list = true
vim.o.listchars = [[tab:▸ ,trail:·]]
vim.o.nrformats = 'bin,hex,unsigned'
vim.o.mouse = ''

-- nvim-cmp がなくても下の設定でlspをomni補完できる
-- vim.o.completeopt = 'menu'
-- vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'

-- keymap
vim.keymap.set('n', 'vv', 'vg_', { noremap = true })
vim.keymap.set('v', '.',  ':normal .<cr>', { noremap = true })
vim.keymap.set('n', '<c-w>g', '<c-w>sgg', { noremap = true })
vim.keymap.set('n', '<c-w>-', ':<c-u>sp %:h<cr>', { noremap = true })
vim.keymap.set('t', '<c-w>', [[<c-\><c-n><c-w>]], { noremap = true })
vim.keymap.set('t', '<esc><esc>', [[<c-\><c-n>]], { noremap = true })
vim.keymap.set('t', '<leader>w', '<cmd>setlocal wrap!<cr>', { noremap = true })
vim.keymap.set('n', 'H', '20zh', { noremap = true })
vim.keymap.set('n', 'L', '20zl', { noremap = true })

local mygroup = 'MyVimrc'
vim.api.nvim_create_augroup(mygroup, { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  group = mygroup,
  pattern = 'plugins.lua',
  callback = function()
    vim.cmd 'source <afile> | PackerSync'
  end
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  group = mygroup,
  pattern = '*',
  callback = function()
    vim.cmd 'checktime'
  end
})

vim.o.clipboard = ''
vim.api.nvim_create_autocmd('TextYankPost', {
  group = mygroup,
  pattern = '*',
  callback = function()
    if vim.v.event.operator == 'y' then
      vim.fn.setreg('+', vim.fn.getreg(''))
    end
  end
})

--------------------------------------------------------------------------------
-- FileType
--------------------------------------------------------------------------------
local filetype_config = {
  go = function()
    vim.bo.expandtab = false
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
  end,
  python = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
  end,
  yaml = function()
    vim.bo.lisp = true
  end
}

for filetype, config in pairs(filetype_config) do
  vim.api.nvim_create_autocmd('FileType', {
    group = mygroup,
    pattern = filetype,
    callback = config,
  })
end

--------------------------------------------------------------------------------
-- Quickfix
--------------------------------------------------------------------------------
local function toggle_quickfix()
  local nr = vim.fn.winnr('$')
  vim.cmd 'cwindow'
  local nr2 = vim.fn.winnr('$')
  if nr == nr2 then
    vim.cmd 'cclose'
  end
end
vim.keymap.set('n', '<space>q', toggle_quickfix, { noremap = true })
vim.keymap.set('n', ']q', ':<c-u>cn<cr>', { silent = true })
vim.keymap.set('n', '[q', ':<c-u>cp<cr>', { silent = true })

--------------------------------------------------------------------------------
-- Google
--------------------------------------------------------------------------------

local function google(words)
  q = table.concat(words, '+')
  os.execute(string.format('open "%s%s"', 'https://www.google.com/search?q=', q))
end
vim.api.nvim_create_user_command('Google', function(args) google(args.fargs) end, { nargs = '*' })
vim.keymap.set('n', '<leader>gg', ':Google <c-r><c-w><cr><cr>', { noremap = true })
vim.keymap.set('v', '<leader>gg', '"zy:Google <c-r>z<cr>', { noremap = true })

--------------------------------------------------------------------------------
-- Compile Vsnip
--------------------------------------------------------------------------------

local function edit_vsnip_src(opts)
  local filetype
  if opts.args == '' then
    filetype = vim.bo.filetype
  else
    filetype = opts.args
  end
  local snip_src = string.format('~/.vim/vsnip/src/%s.toml', filetype)
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = mygroup,
    pattern = snip_src,
    callback = function()
      os.execute(string.format('~/.vim/vsnip/transpile.sh %s', snip_src))
    end
  })
  vim.cmd('edit ' .. snip_src)
end

vim.api.nvim_create_user_command('VsnipEdit', edit_vsnip_src, { nargs = '?' })

--------------------------------------------------------------------------------
-- Terraform Utilities
--------------------------------------------------------------------------------

local function open_aws_provider_document()
  local line = vim.fn.getline('.')
  local type, name = string.match(line, [[(%w+) "aws_([%w_]+)"]])
  local resource_type = {
    resource = 'resources',
    data = 'data-sources',
  }
  local url = string.format(
    'https://registry.terraform.io/providers/hashicorp/aws/latest/docs/%s/%s',
    resource_type[type], name)
  os.execute(string.format('open "%s"', url))
end
vim.keymap.set('n', '<leader>d', open_aws_provider_document, { noremap = true })

local function open_external_module()
  local line = vim.fn.getline('.')
  local repo, path, tag = string.match(line, [[(github.com.+)//(.+)?ref=(.+)"]])
  local url = string.format('https://%s/tree/%s/%s', repo, tag, path)
  os.execute(string.format('open "%s"', url))
end
vim.keymap.set('n', '<leader>m', open_external_module, { noremap = true })
