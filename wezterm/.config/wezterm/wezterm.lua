local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local fonts = {
	"Monaspace Neon",
	"Monaspace Xenon",
	"Monaspace Krypton",
	"Monaspace Radon",
	"Monaspace Argon",
	"MonoLisa",
	"Geist Mono",
	"SF Mono",
	"Comic Code Ligatures",
	-- "Liga SFMono Nerd Font",
	-- "Fira Code Retina",
	-- "DankMono Nerd Font",
	-- "Monego Ligatures",
	-- "Operator Mono Lig",
	-- "Gintronic",
	-- "Cascadia Code",
	-- "JetBrainsMono Nerd Font Mono",
	-- "Victor Mono",
	-- "Inconsolata",
	-- "TempleOS",
	-- "Apercu Pro",
}
local emoji_fonts = { "Apple Color Emoji", "Joypixels", "Twemoji", "Noto Color Emoji", "Noto Emoji" }

-- https://www.monolisa.dev/playground
-- https://fontdrop.info/#/?darkmode=true
-- https://helpx.adobe.com/fonts/using/open-type-syntax.html
-- SF Mono
-- config.harfbuzz_features =
-- 	{ "-c2sc", "liga", "ccmp", "locl", "-smcp", "-ss03", "-ss04", "ss05", "ss06", "ss07", "-ss08", "-ss09" }
-- Fira Code
-- https://github.com/tonsky/FiraCode/wiki/How-to-enable-stylistic-sets
-- config.harfbuzz_features = { "cv01", "cv02", "cv06", "cv10", "cv13", "ss01", "ss04", "ss05", "ss02" }
-- monaspace
-- config.harfbuzz_features =
-- 	{ "calt", "liga", "dlig", "zero", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" }
-- geist /> === // 0O
-- config.harfbuzz_features =
-- 	{ "calt", "liga", "dlig", "zero", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "-ss09" }
-- monolisa
-- @ <=0xF \\ \n
config.harfbuzz_features = {
	"calt",
	"liga",
	"zero",
	"-ss01",
	"ss02",
	"-ss03",
	"ss04",
	"ss05",
	"-ss06",
	"-ss07",
	"-ss08",
	"-ss09",
	"ss10",
	"ss11",
	"ss12",
	"-ss13",
	"ss14",
	"ss15",
	"ss16",
	"ss17",
	"ss18",
}
config.font = wezterm.font_with_fallback({ fonts[1], emoji_fonts[1], emoji_fonts[2] })
-- config.disable_default_key_bindings = true
config.front_end = "WebGpu"
config.enable_scroll_bar = false
config.scrollback_lines = 10240
config.font_size = 16
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.automatically_reload_config = true
config.default_cursor_style = "BlinkingBar"
config.initial_cols = 80
config.initial_rows = 25
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
-- config.window_decorations = "RESIZE|TITLE"
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = {
	left = 30,
	right = 30,
	top = 30,
	bottom = 30,
}
config.window_frame = {
	font = wezterm.font({ family = "SF Mono" }),
	-- font = wezterm.font({ family = "Geist Mono" }),
	active_titlebar_bg = "#1e1e1e",
	inactive_titlebar_bg = "#1e1e1e",
	font_size = 15.0,
}

config.color_scheme = "OneDark (base16)"
config.color_scheme = "OneDark"
config.color_schemes = {
	["OneDark"] = {
		foreground = "#f0f6fc",
		background = "#1e1e1e",
		-- background = "#21262d",
		-- background = "#1e1e2e",
		-- background = "#1a1b26",
		cursor_bg = "#b1cad8",
		cursor_fg = "#21262d",
		cursor_border = "#CF7277",
		selection_fg = "#21262d",
		selection_bg = "#2A4668",
		scrollbar_thumb = "#30363d",
		split = "#6e7681",

		ansi = {
			"#8b949e",
			"#ff7b72",
			"#aff5b4",
			"#FFE08C",
			"#79c0ff",
			"#d2a8ff",
			"#a5d6ff",
			"#c9d1d9",
		},
		brights = {

			"#8b949e",
			"#ff7b72",
			"#aff5b4",
			"#FFE08C",
			"#79c0ff",
			"#d2a8ff",
			"#a5d6ff",
			"#c9d1d9",
		},
	},
}

config.colors = {
	tab_bar = {
		background = "#808080",
		active_tab = {
			bg_color = "#1e1e1e",
			fg_color = "#c8c8c8",
		},
		inactive_tab = {
			bg_color = "#30363d",
			fg_color = "#8b949e",
		},
		inactive_tab_hover = {
			bg_color = "#484f58",
			fg_color = "#b1bac4",
		},
		new_tab = {
			bg_color = "#30363d",
			fg_color = "#8b949e",
		},
		new_tab_hover = {
			bg_color = "#484f58",
			fg_color = "#b1bac4",
		},
	},
}

local act = wezterm.action

config.keys = {
	-- Using SHIFT to copy paste in the terminal/neovim to NO-SHIFT in the browser is scuffed.
	-- But if I copy with Ctrl + c, I lose the default keybind to stop a terminal process.
	-- The internet is annoyed that I want to fix this.
	-- I failed in zshrc, but this works in wezterm.
	{ key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	{ key = "c", mods = "CTRL", action = wezterm.action({ CopyTo = "Clipboard" }) },
	-- \x03 is what the default Ctrl + c keybind sends to end a terminal process.
	-- It means "End of Text" or "ETX" in the ASCII table.
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ SendString = "\x03" }) },

	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "x",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},

	-- I want to use <C-S-l> in harpoon, and it was some weird error anyway. so I disabled this keybind.
	{
		key = "L",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

-- Tab config
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.window_padding = {
	left = 15,
	right = 15,
	top = 15,
	bottom = 0,
}
config.window_frame = {
	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 11.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#333333",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#333333",
}
config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#575757",
	},
}

-- CTRL+SHIFT + number to activate that tab
for i = 1, 8 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = act.ActivateTab(i - 1),
	})
end

return config
