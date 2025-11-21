-- Yatline status bar with rainbow theme
require("yatline"):setup({
	section_separator = { open = "", close = "" },
	part_separator = { open = "", close = "" },
	inverse_separator = { open = "", close = "" },

	style_a = {
		fg = "#3c3836",
		bg_mode = {
			normal = "#85c4b8",
			select = "#d99368",
			un_set = "#7d9dcc"
		}
	},
	style_b = { bg = "#7c6f9f", fg = "#e0e0e0" },
	style_c = { bg = "#4d3d52", fg = "#e0e0e0" },

	permissions_t_fg = "#99d1a0",
	permissions_r_fg = "#d9c9a0",
	permissions_w_fg = "#f38ba8",
	permissions_x_fg = "#99d1a0",
	permissions_s_fg = "#7c6f9f",

	tab_width = 20,
	tab_use_inverse = false,

	selected = { icon = "󰻭", fg = "#d9c9a0" },
	copied = { icon = "", fg = "#99d1a0" },
	cut = { icon = "", fg = "#f38ba8" },

	total = { icon = "󰮍", fg = "#d9c9a0" },
	succ = { icon = "", fg = "#99d1a0" },
	fail = { icon = "", fg = "#f38ba8" },
	found = { icon = "󰮕", fg = "#85c4b8" },
	processed = { icon = "󰐍", fg = "#7d9dcc" },

	show_background = true,

	header_line = {
		left = {
			section_a = {
				{ type = "line", custom = false, name = "tabs", params = { "left" } },
			},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {},
			section_b = {},
			section_c = {},
		},
	},

	status_line = {
		left = {
			section_a = {
				{ type = "string", custom = false, name = "tab_mode" },
			},
			section_b = {
				{ type = "string", custom = false, name = "hovered_size" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_name" },
				{ type = "coloreds", custom = false, name = "count" },
			},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "cursor_position" },
			},
			section_b = {
				{ type = "string", custom = false, name = "cursor_percentage" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
				{ type = "coloreds", custom = false, name = "permissions" },
			},
		},
	},
})
