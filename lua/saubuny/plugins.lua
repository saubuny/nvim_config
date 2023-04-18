local fn = vim.fn

-- Auto-install Packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing Packer... Please restart Neovim")
	vim.cmd([[packadd packer.nvim]])
end

-- Autoreload Neovim on plugins.lua save
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Packer protected call (No annoying errors)
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Packer settings
packer.init({
	display = {
		-- Display in a popup window
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Self-managing packer

	-- Colorschemes
	use("navarasu/onedark.nvim")
	use("arcticicestudio/nord-vim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("folke/tokyonight.nvim")
	use("rmehri01/onenord.nvim")

	-- Better looking indents
	use("lukas-reineke/indent-blankline.nvim")

	-- Fancy bar at the bottom
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- File tree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	-- Annoying dependencies that act weird
	use("nvim-lua/plenary.nvim")
	use("nvim-tree/nvim-web-devicons")

	-- Fuzzy finding (make sure ripgrep is installed)
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Rainbow brackets for fun
	-- use 'mrjones2014/nvim-ts-rainbow'

	-- Terminal
	use({ "akinsho/toggleterm.nvim", tag = "*" })

	-- Syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- Completion
	use("hrsh7th/nvim-cmp") -- The plugin itself
	use("hrsh7th/cmp-buffer") -- Buffer completion
	use("hrsh7th/cmp-path") -- Path completion
	use("hrsh7th/cmp-cmdline") -- Command line completion
	use("hrsh7th/cmp-nvim-lsp") -- LSP completion
	use("saadparwaiz1/cmp_luasnip") -- Luasnip completions
	use("hrsh7th/cmp-nvim-lua") -- Vim's api
	use("KadoBOT/cmp-plugins") -- Plugins
	use("rafamadriz/friendly-snippets") -- Plugins

	-- Snippets
	use("L3MON4D3/LuaSnip") -- Snippet engine

	-- LSP
	use("neovim/nvim-lspconfig") -- Configurations for Nvim LSP
	use("williamboman/mason.nvim") -- Easy installion of servers + linters + formatters
	use("williamboman/mason-lspconfig.nvim") -- Compatibility with Nvim LSP
	use("j-hui/fidget.nvim") -- Visual UI for LSP progress

	-- Formatting
	use("jose-elias-alvarez/null-ls.nvim") -- Language server that injects formatters
	use("jay-babu/mason-null-ls.nvim") -- Compatibility with Mason

	-- Tabs
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	-- Comment toggling
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Close html tags automatically
	use("windwp/nvim-ts-autotag")

	-- Rust anaylizer
	use("simrat39/rust-tools.nvim")

	-- Autoclose brackets and quotes
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Git integration
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- Markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- nand2tetris
	use("sevko/vim-nand2tetris-syntax")

	-- Startup menu
	use({
		"startup-nvim/startup.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	})

	-- Automatically set up packer config (Put at end)
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
