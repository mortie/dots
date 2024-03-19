#!/bin/sh
while :; do
	kitty --class scratchpad
	echo "Kitty exited with code $?, restarting" >&2
done
