#!/bin/sh

set -e

screenshot_path="$HOME/cloud/screenshots"
base="screenshot-$(date +'%Y-%m-%dT%H:%M:%S').png"
file="$screenshot_path/$base"

if [ "$1" = select ]; then
	grim -g "$(slurp)" "$file"
elif [ -z "$1" ]; then
	grim "$file"
else
	echo "Usage: $0 [select]"
	exit 1
fi

notify-send "Screenshot captured." "$base"
