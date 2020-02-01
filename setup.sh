#!/bin/sh

srcdir="$(readlink -f "$(dirname "$0")/dots")"
destdir="$HOME"

link() {
	from="$srcdir/$1"
	if [ -z "$2" ]; then
		to="$destdir/.$1"
	else
		to="$destdir/$2"
	fi

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

link bashrc
link config/nvim/init.vim
link local/share/nvim/site/autoload/plug.vim
