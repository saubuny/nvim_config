require('bufferline').setup({
  options = {
    -- Show diagnostics on line
    diagnostics = 'nvim_lsp',
    offsets = { { filetype = 'NvimTree', text = 'File Explorer' } }
  }
})
