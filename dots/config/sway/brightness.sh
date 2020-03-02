#!/bin/sh

device="/sys/class/backlight/intel_backlight"

# Backlight changer script.
# The math in the 'changeto' commands is strange because shell math
# is integer math; if I was working with float, I would treat 'max / 100'
# as 1%, so incrementing by $2% would be '(max / 100) * $2', but with integer
# math, that initial '(max / 100)' would lose a ton of precision.
# '(max * $2 * 100) / 1000' ensures that we only lose precision in the last step.

curr="$(cat "$device/brightness")"
max="$(cat "$device/max_brightness")"

changeto() {
	if [ "$1" -gt "$max" ]; then bri="$max"
	elif [ "$1" -lt 0 ]; then bri=0
	else bri="$1"
	fi

	echo "$bri" > "$device/brightness"
}

if [ "$1" = set ] && ! [ -z "$2" ]; then
	changeto "$(((max * $2 * 100) / 10000))"
elif [ "$1" = inc ] && ! [ -z "$2" ]; then
	changeto "$((curr + (max * $2 * 100) / 10000))"
elif [ "$1" = dec ] && ! [ -z "$2" ]; then
	changeto "$((curr - (max * $2 * 100) / 10000))"
else
	echo "Usage: $0 <set|inc|dec> <percent>"
	exit 1
fi
