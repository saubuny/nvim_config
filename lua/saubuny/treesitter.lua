require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"html",
		"c",
		"bash",
		"glsl",
		"json",
		"make",
		"markdown",
		"python",
		"rust",
		"toml",
		"typescript",
		"lua",
		"javascript",
		"tsx",
		"svelte",
		"help",
		"comment",
		"cmake",
		"css",
		"html",
		"wgsl",
		"svelte",
		"dockerfile",
		"sql",
	},
	-- Other settings
	sync_install = false,
	auto_install = true,
	-- For when ensure_installed = "all"
	ignore_install = {},
	-- Highlighting settings
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
})
