#!/bin/sh
while :; do
	kitty --class scratchpad
done &
pid=$!

swaymsg -m -t subscribe '[]'
kill "$pid"
