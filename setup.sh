#!/bin/sh

srcdir="$(readlink -f "$(dirname "$0")/dots")"
destdir="$HOME"

link() {
	from="$srcdir/$1"
	to="$destdir/$2"
	echo "link '$from'"
	echo "  -> '$to'"
	if ! rm -f "$to"; then
		echo "'rm' failed!"
		echo
		return
	fi
	if ! mkdir -p "$(dirname "$to")"; then
		echo "'mv' failed!"
		echo
		return
	fi
	if ! ln -s "$from" "$to"; then
		echo "'ln' failed!"
		echo
		return
	fi
}

link bashrc .bashrc
link config/nvim/init.vim .config/nvim/init.vim
