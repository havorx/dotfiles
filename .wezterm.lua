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
config.color_scheme = "Hardcore"

config.max_fps = 100
config.animation_fps = 100
config.window_decorations = "RESIZE"
config.font_size = 13.0
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
  {
    key = "n",
    mods = "SHIFT|CTRL",
    action = wezterm.action.ToggleFullScreen,
  },
}
config.native_macos_fullscreen_mode = true

config.line_height = 1.2

-- wezterm default border padding
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
