-- Native LSP client (neovim >= 0.11). Servers are defined here directly, so
-- nvim-lspconfig is not needed. A server is only enabled when its executable
-- is found, which keeps this safe on machines that lack some of them.

-- ~/.vimrc is a symlink into the dotfiles repo, where pyright is installed
-- locally (.vim/package.json) in case it is not on $PATH.
local function find_exe(name)
  if vim.fn.executable(name) == 1 then
    return name
  end
  local vimrc = vim.g.vimrc and vim.fn.fnamemodify(vim.g.vimrc, ':h') or nil
  local local_bin = vimrc and (vimrc .. '/node_modules/.bin/' .. name) or nil
  if local_bin and vim.fn.executable(local_bin) == 1 then
    return local_bin
  end
end

local servers = {
  pyright = {
    exe = 'pyright-langserver',
    config = {
      cmd = { 'pyright-langserver', '--stdio' },
      filetypes = { 'python' },
      root_markers = {
        'pyrightconfig.json', 'pyproject.toml', 'setup.py', 'setup.cfg',
        'requirements.txt', 'Pipfile', '.git',
      },
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'openFilesOnly',
          },
        },
      },
    },
  },
  yamlls = {
    exe = 'yaml-language-server',
    config = {
      cmd = { 'yaml-language-server', '--stdio' },
      filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
      root_markers = { '.git' },
      settings = { yaml = { keyOrdering = false } },
    },
  },
  html = {
    exe = 'vscode-html-language-server',
    config = {
      cmd = { 'vscode-html-language-server', '--stdio' },
      filetypes = { 'html' },
      root_markers = { 'package.json', '.git' },
      init_options = {
        provideFormatter = true,
        embeddedLanguages = { css = true, javascript = true },
        configurationSection = { 'html', 'css', 'javascript' },
      },
    },
  },
  lemminx = {
    exe = 'lemminx',
    config = {
      cmd = { 'lemminx' },
      filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg' },
      root_markers = { '.git' },
    },
  },
}

for name, server in pairs(servers) do
  local exe = find_exe(server.exe)
  if exe then
    server.config.cmd[1] = exe
    vim.lsp.config(name, server.config)
    vim.lsp.enable(name)
  end
end

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
  float = { border = 'rounded', source = true },
})

-- Completion popup: show the menu even for a single match, and do not
-- preselect an entry so <CR> still inserts a newline unless one was picked.
vim.o.completeopt = 'menu,menuone,noselect,popup'

local function pum_selected()
  return vim.fn.pumvisible() == 1 and vim.fn.complete_info({ 'selected' }).selected >= 0
end

local function has_text_before_cursor()
  local col = vim.fn.col('.') - 1
  return col > 0 and vim.fn.getline('.'):sub(col, col):match('%s') == nil
end

vim.keymap.set('i', '<Tab>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  elseif has_text_before_cursor() then
    return '<C-x><C-o>'
  end
  return '<Tab>'
end, { expr = true, desc = 'Next completion / trigger completion' })

vim.keymap.set('i', '<S-Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { expr = true, desc = 'Previous completion' })

vim.keymap.set('i', '<CR>', function()
  return pum_selected() and '<C-y>' or '<CR>'
end, { expr = true, desc = 'Accept selected completion' })

local augroup = vim.api.nvim_create_augroup('aug_lsp', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local function map(modes, lhs, rhs, desc)
      vim.keymap.set(modes, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    -- Neovim already maps K (hover), grn (rename), gra (code action),
    -- grr (references), gri, grt, gO, <C-s> (insert signature help).
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    map('n', 'gy', vim.lsp.buf.type_definition, 'Go to type definition')
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
    map('n', 'gr', vim.lsp.buf.references, 'References')
    map({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, 'Code action')
    map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, 'Format buffer')
    map('n', '<leader>o', vim.lsp.buf.document_symbol, 'Document symbols')
    map('n', '<leader>ws', vim.lsp.buf.workspace_symbol, 'Workspace symbols')
    map('n', '<leader>e', vim.diagnostic.open_float, 'Line diagnostics')
    map('n', '<leader>d', vim.diagnostic.setloclist, 'Buffer diagnostics')
    map('n', '[g', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Previous diagnostic')
    map('n', ']g', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Next diagnostic')

    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end

    if client and client:supports_method('textDocument/documentHighlight') then
      local group = vim.api.nvim_create_augroup('aug_lsp_highlight_' .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd('CursorHold', {
        group = group, buffer = bufnr, callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter' }, {
        group = group, buffer = bufnr, callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
