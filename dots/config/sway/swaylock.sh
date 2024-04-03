#!/bin/sh

args="--ignore-empty-password -S --effect-blur 10x5"

lock() {
	touch ~/.swaylocked
	if ~/.local/bin/swaylock "$@"; then
		rm -f ~/.swaylocked
	fi
}

if [ "$1" = immediate ]; then
	lock $args &
else
	lock $args --grace 20 --fade-in 10 &
fi
