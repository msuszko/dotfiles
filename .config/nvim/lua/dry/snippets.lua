-- Snippet completion from friendly-snippets (VSCode format), served to the
-- native LSP completion by a tiny in-process language server. Selecting a
-- snippet expands it with vim.snippet, so <Tab>/<S-Tab> jump between its
-- placeholders (see lsp.lua).

-- Filetypes whose snippets are filed under other names in package.json.
local aliases = {
  sh = { 'shell', 'shellscript' },
  bash = { 'sh', 'shell', 'shellscript' },
  zsh = { 'sh', 'shell', 'shellscript' },
  text = { 'plaintext' },
  tex = { 'latex' },
  plaintex = { 'tex', 'latex' },
  cs = { 'csharp' },
  ps1 = { 'powershell' },
  htmldjango = { 'django', 'djangohtml', 'html' },
  rmd = { 'rmarkdown' },
  eruby = { 'erb' },
}

local root = (vim.api.nvim_get_runtime_file('snippets/global.json', true)[1] or ''):match('^(.*)/snippets/global%.json$')
if not root then
  return
end

local ok, package = pcall(function()
  return vim.json.decode(table.concat(vim.fn.readfile(root .. '/package.json'), '\n'))
end)
if not ok then
  return
end

local file_cache = {}  -- path -> decoded snippet file
local items_cache = {} -- filetype -> completion items

local function read_snippets(path)
  if file_cache[path] == nil then
    local read_ok, decoded = pcall(function()
      return vim.json.decode(table.concat(vim.fn.readfile(path), '\n'))
    end)
    file_cache[path] = read_ok and decoded or {}
  end
  return file_cache[path]
end

local function items_for(ft)
  if items_cache[ft] then
    return items_cache[ft]
  end

  local wanted = { [ft] = true, all = true }
  for _, alias in ipairs(aliases[ft] or {}) do
    wanted[alias] = true
  end

  local items, seen = {}, {}
  for _, entry in ipairs(package.contributes.snippets) do
    local languages = type(entry.language) == 'table' and entry.language or { entry.language }
    local matches = vim.iter(languages):any(function(language) return wanted[language] end)
    if matches and not seen[entry.path] then
      seen[entry.path] = true
      for name, snippet in pairs(read_snippets(root .. '/' .. entry.path:gsub('^%./', ''))) do
        local body = type(snippet.body) == 'table' and table.concat(snippet.body, '\n') or snippet.body
        local prefixes = type(snippet.prefix) == 'table' and snippet.prefix or { snippet.prefix }
        for _, prefix in ipairs(prefixes) do
          items[#items + 1] = {
            label = prefix,
            kind = vim.lsp.protocol.CompletionItemKind.Snippet,
            detail = snippet.description or name,
            documentation = { kind = 'markdown', value = '```' .. ft .. '\n' .. body .. '\n```' },
            insertText = body,
            insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
          }
        end
      end
    end
  end

  items_cache[ft] = items
  return items
end

local function server()
  local closing = false
  local handlers = {
    initialize = function()
      return { capabilities = { completionProvider = { resolveProvider = false } }, serverInfo = { name = 'snippets' } }
    end,
    ['textDocument/completion'] = function(params)
      local bufnr = vim.uri_to_bufnr(params.textDocument.uri)
      return { isIncomplete = false, items = items_for(vim.bo[bufnr].filetype) }
    end,
  }

  return {
    request = function(method, params, callback)
      local handler = handlers[method]
      callback(nil, handler and handler(params) or nil)
      return true, 1
    end,
    notify = function()
      return true
    end,
    is_closing = function()
      return closing
    end,
    terminate = function()
      closing = true
    end,
  }
end

vim.lsp.config('snippets', { cmd = server })
vim.lsp.enable('snippets')
