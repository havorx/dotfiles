-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night"
config.colors = {
	background = "black",
}

config.max_fps = 100
config.animation_fps = 100
config.window_decorations = "RESIZE"
config.font_size = 11.0
config.hide_tab_bar_if_only_one_tab = true
config.disable_default_mouse_bindings = true

config.enable_kitty_keyboard = true
config.canonicalize_pasted_newlines = "LineFeed"

config.keys = {
	-- {
	-- 	key = "n",
	-- 	mods = "SHIFT|CTRL",
	-- 	action = wezterm.action.ToggleFullScreen,
	-- },
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action.SendString("\x1b\n"),
	},
	{
		key = "P",
		mods = "CTRL",
		action = wezterm.action({
			QuickSelectArgs = {
				patterns = {
					[[https?://[^\s\])\"'>,;]+(?:\([^\)]*\)[^\s\])\"'>,;]*)*]],
				},
				action = wezterm.action_callback(function(window, pane)
					local url = window:get_selection_text_for_pane(pane)
					wezterm.log_info("opening: " .. url)
					wezterm.open_with(url)
				end),
			},
		}),
	},
}

config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" })

-- config.front_end = "WebGpu"

-- config.webgpu_power_preference = "HighPerformance"

-- config.line_height = 1.0

if wezterm.target_triple:find("windows") then
	config.default_domain = "WSL:Ubuntu"
	config.ssh_domains = {
		{
			name = 'wsl-ssh',
			remote_address = 'localhost:22',
			username = os.getenv('USER'),
			multiplexing = 'None',
		},
	}
	config.launch_menu = {
		{
			label = "pwsh",
			args = { os.getenv("LOCALAPPDATA") .. "\\Microsoft\\WindowsApps\\pwsh.exe", "-nologo" },
			domain = { DomainName = "local" },
			cwd = "C:\\Users\\havorx",
		},
	}
end

if wezterm.target_triple:find("darwin") then
	config.native_macos_fullscreen_mode = true
end

config.window_padding = {
	left = 0,
	right = 0,
	bottom = 0,
}

config.audible_bell = "Disabled"

-- and finally, return the configuration to wezterm
return config