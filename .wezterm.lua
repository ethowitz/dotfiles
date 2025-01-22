local wezterm = require("wezterm")

return {
	color_scheme = "Tokyo Night Storm",

	-- Font and Cursor
	font = wezterm.font_with_fallback({
		{
			family = "Iosevka SS12",
			weight = 600,
			harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
		},
	}),
	font_size = 12.1,
	line_height = 1.1,
	default_cursor_style = "BlinkingUnderline",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 500,

	-- Graphics
	max_fps = 240,
	enable_wayland = false,

	-- Window
	hide_tab_bar_if_only_one_tab = true,
	window_padding = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 4,
	},
	window_decorations = "RESIZE",
	initial_rows = 70,
	initial_cols = 120,

	-- Terminal
	term = "wezterm",
	scrollback_lines = 50000,
	audible_bell = "Disabled",

	-- Keys
	keys = {
		{
			key = "f",
			mods = "SHIFT|CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "t",
			mods = "SUPER",
			action = wezterm.action({ SpawnCommandInNewTab = { cwd = wezterm.home_dir } }),
		},
	},
}
