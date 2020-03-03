#!/bin/sh

percent() {
	echo "$((($1 * 100) / $2))%"
}

print_date() {
	date +'%Y-%m-%d %H:%M:%S'
}

print_battery() {
	percent "$(cat "$1/charge_now")" "$(cat "$1/charge_full")"
}

print_network() {
	nmcli device | grep "^$1" | awk -F '  +' '{print $3 " " $4}' | sed 's/ $//'
}

print_backlight() {
	percent "$(cat "$1/brightness")" "$(cat "$1/max_brightness")"
}

update() {
	echo \
		"BRI: $(print_backlight /sys/class/backlight/intel_backlight) |" \
		"NET: $(print_network wlp2s0) |" \
		"BAT: $(print_battery /sys/class/power_supply/BAT0) |" \
		"$(print_date)"
	return $?
}

# For 'reload' to work, we need a PID file.
dir="$(dirname "$0")"
file="$(basename "$0")"
pidfile="$dir/.$file.pid~"

# Reloading works by sending SIGUSR1 to an existing status process.
if [ "$1" = "reload" ]; then
	kill -USR1 "$(cat "$pidfile")"
	exit $?
fi

# Write our own PID, and trap USR1
# (being sent USR1 will interrupt the 'wait $!' anyways, so we don't need
# to actually do anything in response)
echo "$$" > "$pidfile"
trap true USR1

# 'sleep 1 & wait $!' will sleep for 1 second, but it'll be interrupted
# by SIGUSR1.
while update; do sleep 1 & wait $!; done
