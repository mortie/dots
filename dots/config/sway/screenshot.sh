#!/bin/sh

set -e

host="https://p.mort.coffee"

shot() {
	if [ -z "$1" ]; then
		grim -t ppm -
	else
		grim -t ppm -g "$1" -
	fi
}

compress() {
	convert ppm:- jpeg:-
}

strip_nl() {
	sed -z '$ s/\n$//'
}

selection=""
if [ "$2" = select ]; then
	selection="$(slurp)" || ret="$?"
	if [ "$ret" = 1 ]; then
		exit 0 # User probably hit esc to cancel
	elif ! [ -z "$ret" ]; then
		notify-send --urgency critical "Slurp command failed." "Exit code: $ret"
		exit 1
	fi
fi

if [ "$1" = upload ]; then
	url="$(shot "$selection" | compress | curl --upload-file - "$host/screenshot.jpg")" || ret="$?"
	if ! [ -z "$ret" ]; then
		notify-send --urgency critical "Failed to capture" "Exit code: $ret"
		exit 1
	fi

	echo "$url" | strip_nl | wl-copy
elif [ "$1" = copy ]; then
	shot "$selection" | wl-copy || ret="$?"
	if ! [ -z "$ret" ]; then
		notify-send --urgency critical "Failed to capture" "Exit code: $ret"
		exit 1
	fi
else
	echo "Usage: $0 <upload|copy> [select]"
	exit 1
fi


