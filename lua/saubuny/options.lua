-- :help options

local options = {
	-- Indentation
	expandtab = true,
	smartindent = true,
	shiftwidth = 2,
	tabstop = 2,
	-- Visuals
	number = true,
	numberwidth = 4,
	relativenumber = true,
	cmdheight = 1,
	splitbelow = true,
	splitright = true,
	wrap = true,
	showmode = true,
	termguicolors = true,
	signcolumn = "yes",
	-- Editing
	fileencoding = "utf-8",
	clipboard = "unnamedplus",
	mouse = "c",
	completeopt = { "menuone", "noselect" },
}

-- Let - work with word commands
vim.cmd([[set iskeyword+=-]])

-- Make header files use C syntax
vim.cmd([[autocmd BufNewFile,BufRead *.h setlocal filetype=c]])

-- Remove annoying autocommenting
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})

-- Apply options
for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Larger indents for some languages
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust", "hdl", "asm" },
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
	end,
})
