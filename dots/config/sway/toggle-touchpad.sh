#!/bin/sh
set -ue

disabled_file="$XDG_RUNTIME_DIR/touchpad-disabled.$WAYLAND_DISPLAY"

if [ -e "$disabled_file" ]; then
	# Toggle disabled -> enabled
	rm -f "$disabled_file"
	swaymsg input type:touchpad events enabled
	swaymsg seat seat0 hide_cursor 0
else
	# Toggle enabled -> disabled
	touch "$disabled_file"
	swaymsg input type:touchpad events disabled
	swaymsg seat seat0 hide_cursor 1
fi
