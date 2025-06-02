#!/bin/sh

sleep 1
while :; do
	kitty --class scratchpad
	echo "Kitty exited with code $?, restarting" >&2
done
