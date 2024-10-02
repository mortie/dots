local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.font = wezterm.font "Fira Code"

config.colors = {
	foreground = "white",
	background = "black",
}

config.keys = {
  { key = '{', mods = 'SHIFT|ALT', action = act.MoveTabRelative(-1) },
  { key = '}', mods = 'SHIFT|ALT', action = act.MoveTabRelative(1) },
}

return config
