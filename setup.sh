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
	if ! rm -rf "$to"; then
		echo "'rm' failed!"
		echo
		return
	fi
	if ! mkdir -p "$(dirname "$to")"; then
		echo "'mkdir' failed!"
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
link config/nvim/syntax
link config/nvim/coc-settings.json
link config/kitty/kitty.conf
link config/sway/config
link config/sway/brightness.py
link config/sway/screenshot.sh
link config/sway/status.sh
link config/sway/lock.sh
link config/sway/idle.sh
link config/sway/scratch.sh
link local/share/nvim/site/autoload/plug.vim
link local/bin/pwrsave
link local/bin/gdx
