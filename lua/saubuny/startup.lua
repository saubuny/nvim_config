require("startup").setup({
	header = {
		type = "text",
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "Header",
		margin = 5,
		content = {
			[[                               __                ]],
			[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
			[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
			[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
			[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
		},
		default_color = "",
		highlight = "Function",
		oldfiles_amount = 0,
	},
	date = {
		type = "text", -- can be mappings or oldfiles
		align = "center", -- "center", "left" or "right"
		title = "Date", -- title for the folded section
		margin = 5,
		content = function()
			local date = " " .. os.date("%m-%d-%y")
			return { date }
		end,
		highlight = "Function",
		default_color = "",
	},
	body = {
		type = "mapping",
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "Basic Commands",
		margin = 5,
		content = {
			{ " Find File", "Telescope find_files", "<leader>ff" },
			{ "󰙅 Open Tree", "NvimTreeFocus", "<leader>e" },
			{ " New File", "lua require'startup'.new_file()", "<leader>nf" },
			{ " Recent Files", "Telescope oldfiles", "<leader>of" },
			{ " Colorschemes", "Telescope colorscheme", "<leader>cs" },
		},
		highlight = "Function",
		default_color = "",
		oldfiles_amount = 0,
	},
	options = {
		mapping_keys = true, -- display mapping (e.g. <leader>ff)
		cursor_column = 0.5,
		after = function() -- function that gets executed at the end
		end,
		empty_lines_between_mappings = true, -- add an empty line between mapping/commands
		disable_statuslines = true, -- disable status-, buffer- and tablines
		paddings = { 1, 2, 3 }, -- amount of empty lines before each section (must be equal to amount of sections)
	},
	parts = { "header", "date", "body" },
})
