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
config.color_scheme = "carbonfox"
config.colors = {
	background = "black",
}

config.max_fps = 100
config.animation_fps = 100
config.window_decorations = "RESIZE"
config.font_size = 11.0
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "P",
		mods = "CTRL",
		action = wezterm.action({
			QuickSelectArgs = {
				patterns = {
					"https?://\\S+",
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

config.native_macos_fullscreen_mode = true

-- config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })

-- config.front_end = "WebGpu"

-- config.webgpu_power_preference = "HighPerformance"

-- config.line_height = 1.0

-- Spawn a powershell shell in login mode
-- config.default_prog = { "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" }

-- start wezterm in wsl
-- config.default_domain = "WSL:Ubuntu"
-- config.launch_menu = {
-- 	{
-- 		label = "pwsh",
-- 		args = { os.getenv("LOCALAPPDATA") .. "\\Microsoft\\WindowsApps\\pwsh.exe", "-nologo" },
-- 		domain = { DomainName = "local" },
-- 		cwd = "C:\\Users\\havorx",
-- 	},
-- }

config.window_padding = {
	left = 3,
	right = 0,
	-- top = 0,
	bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
