#!/bin/sh

args="-f -S --effect-blur 10x5"

if [ "$1" = immediate ]; then
	~/.local/bin/swaylock $args
else
	~/.local/bin/swaylock $args --grace 10 --fade-in 5
fi
