-- Disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Setup
require("nvim-tree").setup({
	view = {
		hide_root_folder = true,
		-- number = true,
		-- relativenumber = true,
		float = {
			-- enable = true,
		},
	},
	diagnostics = {
		-- enable = true,
		-- show_on_dirs = true,
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	filters = {
		dotfiles = false,
	},
})
