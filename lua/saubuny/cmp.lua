-- Require
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Icons for menu
local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local kind_icons2 = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

-- Setup
cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		-- Documentation
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- Toggle completion
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		-- Navigate completion
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Include icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

			-- Tell us where the completion came from
			vim_item.menu = ({
				buffer = "[Buffer]",
				path = "[Path]",
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
			})[entry.source.name]

			return vim_item
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}, {
		{ name = "luasnip" },
	}, {
		{ name = "path" },
	}, {
		{ name = "nvim_lua" },
	}, {
		{ name = "plugin" },
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
})

require("luasnip.loaders.from_snipmate").lazy_load()

-- Completion for plugins
require("cmp-plugins").setup({
	files = { ".*\\.lua" }, -- default
	-- files = { "plugins.lua", "some_path/plugins/" } -- Recommended: use static filenames or partial paths
})

-- File-type specific
--[[
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})
--]]
-- Command Completion
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
