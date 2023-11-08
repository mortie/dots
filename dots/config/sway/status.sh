#!/bin/sh

show_date() {
	date +"%Y-%m-%d %H:%M"
}

show_battery() {
	charge_full="$(cat /sys/class/power_supply/"$1"/charge_full)"
	charge_now="$(cat /sys/class/power_supply/"$1"/charge_now)"
	echo "$(((charge_now * 100) / charge_full))%"
}

while :; do
	echo "Bat: $(show_battery macsmc-battery) | $(show_date)  "
	sleep 1
done
