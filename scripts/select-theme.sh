#!/bin/bash
# select-theme.sh

theme=$(echo -e "white\nblack\ncream\ngrey" | fuzzel -d -l 5 -p "Select theme > ")

case $theme in
    white)
	cp ~/.config/alacritty/light.toml ~/.config/alacritty/colors.toml
	gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Base-Grey
	emacsclient -e "(load-theme-disable-others 'drh-mono-white)"
	;;
    black)
	cp ~/.config/alacritty/dark.toml ~/.config/alacritty/colors.toml
	gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Dark-Grey
	emacsclient -e "(load-theme-disable-others 'drh-mono-black)"
	;;
    cream)
	cp ~/.config/alacritty/cream.toml ~/.config/alacritty/colors.toml
	gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Base-Grey
	emacsclient -e "(load-theme-disable-others 'drh-mono-cream)"
	;;
    grey)
	cp ~/.config/alacritty/gray.toml ~/.config/alacritty/colors.toml
	gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Dark-Grey
	emacsclient -e "(load-theme-disable-others 'drh-mono-gray)"
	;;
esac


		
