local wezterm = require 'wezterm'
local config = {}

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.font = wezterm.font "Fira Code"

config.colors = {
	foreground = "white",
	background = "black",
}

return config
