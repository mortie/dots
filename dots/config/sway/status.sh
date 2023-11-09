#!/bin/sh

set -e

pidfile="$XDG_RUNTIME_DIR/statusbar.$XDG_SESSION_ID.pid"

if [ "$1" = reload ]; then
	kill "$(cat "$pidfile")"
	exit 0
fi

spinner_idx=0

show_spinner() {
	case "$spinner_idx" in
		0) echo '[.  ]';;
		1) echo '[.. ]';;
		2) echo '[...]';;
		3) echo '[ ..]';;
		4) echo '[  .]';;
		5) echo '[   ]';;
	esac
}

spinner_tick() {
	spinner_idx=$((spinner_idx + 1))
	if [ "$spinner_idx" -gt 5 ]; then
		spinner_idx=0
	fi
}

show_date() {
	date +"%Y-%m-%d %H:%M"
}

show_battery() {
	local charge_full="$(cat /sys/class/power_supply/"$1"/charge_full)"
	local charge_now="$(cat /sys/class/power_supply/"$1"/charge_now)"
	echo "$(((charge_now * 100) / charge_full))%"
}

show_network() {
	local net="$(nmcli --fields STATE,NAME connection show --active | tail -n +2 | grep -v '  lo' | head -n 1)"
	if [ -z "$net" ]; then
		echo "None"
		return
	fi

	local local state="$(echo "$net" | awk '{print $1}')"
	name="$(echo "$net" | awk '{print $2}')"
	if [ "$state" = "activated" ]; then
		echo "$name"
	elif [ "$state" = "activating" ]; then
		echo "$name $(show_spinner)"
	else
		echo "$name ($state)"
	fi
}

show_volume() {
	wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/Volume: \(\S\+\)/\1%/; s/^0//; s/\.//; s/^00/0/;'
}

while :; do
	echo "Vol: $(show_volume) | Net: $(show_network) | Bat: $(show_battery macsmc-battery) | $(show_date)  "
	spinner_tick

	sleep 0.5 &
	echo "$!" > "$pidfile"
	wait
done
