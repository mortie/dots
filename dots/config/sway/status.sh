#!/bin/sh

percent() {
	echo "$((($1 * 100) / $2))$3"
}

print_date() {
	date +'%a %d %b %H:%M:%S'
	#date +'%Y-%m-%d %H:%M:%S'
}

print_battery() {
	perc="$(percent "$(cat "$1/charge_now")" "$(cat "$1/charge_full")")"
	if [ "$(cat "$1/status")" = Charging ]; then
		echo "<span foreground=\"#6eff46\">$perc%</span>"
	elif [ "$perc" -lt 15 ]; then
		echo "<span foreground=\"#ff4646\">$perc%</span>"
	else
		echo "$perc%"
	fi
}

print_turbo() {
	if [ "$(cat "$1/no_turbo")" = 1 ]; then
		echo 0
	else
		echo 1
	fi
}

print_network() {
	nmcli device | grep "  \(connected\|connecting .*\)  " | awk -F '  +' '
		{ORS=""; gsub(/ *$/, "", $4); print sep $3 ": " $4; sep=", "}
		END {if (NR == 0) print "disconnected"}'
}

print_backlight() {
	percent "$(cat "$1/brightness")" "$(cat "$1/max_brightness")" %
}

print_pa_sink() {
	data="$(pactl list | grep "Sink #$1" -A 20)"
	vol="$(printf "%s" "$data" | grep "Volume" | head -n 1 | grep -o '[^ ]\+%' | tr '\n' ' ' | sed 's/ $//' | tr -d '\n')"

	# If muted, colorize the volume.
	if printf "%s" "$data" | grep "Mute: " | head -n 1 | grep "yes" >/dev/null; then
		printf "%s:" "<span foreground=\"#ffb946\">$vol</span>"
	else
		printf "%s:" "$vol"
	fi
}

print_pa_sinks() {
	pactl list | grep "Sink #" | while read -r line; do
		id="$(echo "$line" | sed 's/Sink #//')"
		printf "%s" "#$id $(print_pa_sink "$id"), "
	done | sed 's/, $//'
}

update() {
	echo \
		"SND: $(print_pa_sinks) |" \
		"BRI: $(print_backlight /sys/class/backlight/intel_backlight) |" \
		"NET: $(print_network) |" \
		"BAT: $(print_battery /sys/class/power_supply/BAT0) |" \
		"SPD: $(print_turbo /sys/devices/system/cpu/intel_pstate) |" \
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
if [ "$1" != "no-pidfile" ]; then
	echo "$$" > "$pidfile"
fi
trap true USR1

# 'sleep 1 & wait $!' will sleep for 1 second, but it'll be interrupted
# by SIGUSR1.
while update; do sleep 1 & wait $!; done
