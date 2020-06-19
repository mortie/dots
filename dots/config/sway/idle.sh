#!/bin/sh

swayidle -w -d \
	timeout 60 '~/.config/sway/lock.sh -f --grace 10 --fade-in 6' \
	timeout 80 'swaymsg "output * dpms off"' \
	resume 'swaymsg "output * dpms on"' \
	before-sleep '~/.config/sway/lock.sh -f --fade-in 0'
