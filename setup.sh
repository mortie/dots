#!/bin/sh

srcdir="$(pwd)/dots"
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
link zshrc
link config/nvim/init.vim
link config/nvim/syntax
link config/nvim/coc-settings.json
link config/kitty/kitty.conf
link config/ghostty/config
link config/starstruck.lsp
link config/wezterm/wezterm.lua
link local/share/nvim/site/autoload/plug.vim
link local/bin/pwrsave
link local/bin/gdx
link doom.d/config.el
link doom.d/init.el
link doom.d/packages.el
