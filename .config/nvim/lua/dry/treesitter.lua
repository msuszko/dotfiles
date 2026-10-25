-- nvim-treesitter (main branch) only manages parsers and queries; starting
-- highlighting is up to us. Install parsers on demand with e.g.
--   :lua require('nvim-treesitter').install({ 'python', 'yaml' })
-- and they get picked up the next time a file of that type is opened.

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('aug_treesitter', { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang then
      -- fails quietly when there is no parser for this language
      pcall(vim.treesitter.start, args.buf, lang)
    end
  end,
})
