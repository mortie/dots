#!/bin/sh

srcdir="$(pwd)/dots"
destdir="$HOME"

# Link file:
# link from [to]
# dots/$from -> $HOME/.$from
# dots/$from -> $HOME/$to
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

# Link file to flatpak var dir:
# flatlink ident from [to]
# dots/$from -> $HOME/.var/app/$ident/$from
# dots/$from -> $HOME/.var/app/$ident/$to
flatlink() {
	ident="$1"
	from="$2"
	if [ -z "$3" ]; then
		to=".var/app/$ident/$2"
	else
		to=".var/app/$ident/$3"
	fi

	if [ -d "$destdir/.var/app/$ident" ]; then
		link "$from" "$to"
	else
		echo "Skipping flatlink -> $ident/$to because $ident is not installed"
	fi
}

link bashrc
link zshrc
link config/nvim/init.vim
link config/nvim/syntax
link config/nvim/coc-settings.json
link config/kitty/kitty.conf
link config/ghostty/config
link config/helix/config.toml
link config/starstruck.lsp
link config/wezterm/wezterm.lua
link config/gram/keymap.jsonc
flatlink app.liten.Gram config/gram/keymap.jsonc
link config/gram/settings.jsonc
flatlink app.liten.Gram config/gram/settings.jsonc
link local/share/nvim/site/autoload/plug.vim
link local/bin/pwrsave
link local/bin/gdx
link local/bin/zpv
link doom.d/config.el
link doom.d/init.el
link doom.d/packages.el
