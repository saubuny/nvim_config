-- Mason for installing servers (and some other stuff)
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  keymaps = {
    -- Keymap to expand a package
    toggle_package_expand = "<CR>",
    -- Keymap to install the package under the current cursor position
    install_package = "i",
    -- Keymap to reinstall/update the package under the current cursor position
    update_package = "u",
    -- Keymap to check for new version for the package under the current cursor position
    check_package_version = "c",
    -- Keymap to update all installed packages
    update_all_packages = "U",
    -- Keymap to check which installed packages are outdated
    check_outdated_packages = "C",
    -- Keymap to uninstall a package
    uninstall_package = "X",
    -- Keymap to cancel a package installation
    cancel_installation = "<C-c>",
    -- Keymap to apply language filter
    apply_language_filter = "<C-f>",
  },
})

-- Compatibility with nvim lsp
require("mason-lspconfig").setup({
  -- Servers that mason should automatically install
  ensure_installed = {
    "clangd",
    "jsonls",
    "lua_ls",
    "rust_analyzer",
    "tsserver",
    "tailwindcss",
    "svelte",
    "wgsl_analyzer",
    "cmake",
    "html",
  },
})

-- Cool UI
require("fidget").setup()

-- Server setup (note: tsserver only works when a tsconfig.json or jsconfig.json are present)
local lsp = require("lspconfig")

local on_attach = function(client, bufnr)
  -- Mappings
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "sd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  -- Extra config
  local config = {
    -- virtual_text = {
    --   prefix = "",
    -- },
    virtual_text = false,
    update_in_insert = true,
    underline = false,
    serverity_sort = true,
  }
  vim.diagnostic.config(config)
end

local cap = vim.lsp.protocol.make_client_capabilities()
cap.textDocument.completion.completionItem.snippetSupport = true
local capabilities = require("cmp_nvim_lsp").default_capabilities(cap)

-- Autoformatting!
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Better signs in gutter
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Borders on floating windows
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

-- Lua
lsp["lua_ls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      completion = {
        showWord = "Disable",
      },
    },
  },
})

-- Rust
lsp["rust_analyzer"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
      check = {
        allTargets = false,
      },
    },
  },
})

-- Wgsl Shaders
lsp["wgsl_analyzer"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- HTML
lsp["html"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    css = {
      lint = {
        validProperties = {},
      },
    },
  },
})

-- json
lsp["jsonls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- JS TS TSX
lsp["tsserver"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Tailwind
-- lsp["tailwindcss"].setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- })

-- Svelte
lsp["svelte"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- C
lsp["clangd"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Null-ls for formatting
local null_ls = require("null-ls")

require("mason-null-ls").setup({
  ensure_installed = { "stylua", "rustfmt", "prettier", "clang_format" },
  automatic_installation = true,
  automatic_setup = true,
})

null_ls.setup()

-- Sets up formatters via the automatic_setup param above (and eslint)
require("mason-null-ls").setup({
  handlers = {
    function(source_name, methods)
      -- all sources with no handler get passed here

      -- To keep the original functionality of `automatic_setup = true`,
      -- please add the below.
      require("mason-null-ls.automatic_setup")(source_name, methods)
    end,
    stylua = function(source_name, methods)
      null_ls.register(null_ls.builtins.formatting.stylua)
    end,
    rustfmt = function(source_name, methods)
      null_ls.register(null_ls.builtins.formatting.rustfmt)
    end,
    clang_format = function(source_name, methods)
      null_ls.register(null_ls.builtins.formatting.clang_format)
    end,
    prettier = function(source_name, methods)
      null_ls.register(null_ls.builtins.formatting.prettier.with({
        extra_filetypes = { "toml" },
      }))
    end,
  }
})
