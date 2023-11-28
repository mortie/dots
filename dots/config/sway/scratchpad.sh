#!/bin/sh

while :; do
	echo "running foot" >&2
	foot --title scratchpad
	exit_code=$?
	if [ $exit_code -ge 2 ]; then
		exit 0
	fi
done
