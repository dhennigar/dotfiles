#!/bin/sh
## change alacritty, gtk, and emacs themes when gammastep changes periods
## todo: create a script that allows the user to choose amongst these at will

## $1 = event; $2 = old period; $3 = new period

case $1 in
    period-changed)
	notify-send -t 10000 "Gammastep" "$1 from $2 to $3"
	case $3 in
	    daytime)
		cp ~/.config/alacritty/light.toml ~/.config/alacritty/colors.toml
		gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Base-Grey
		emacsclient -e "(load-theme-disable-others 'drh-mono-white)"
		;;
	    night)
		cp ~/.config/alacritty/dark.toml ~/.config/alacritty/colors.toml
		gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Dark-Grey
		emacsclient -e "(load-theme-disable-others 'drh-mono-black)"
		;;
	    transition)
		if [ $(date +"%H") -lt 12 ]
		then
		    cp ~/.config/alacritty/cream.toml ~/.config/alacritty/colors.toml
		    gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Base-Grey
		    emacsclient -e "(load-theme-disable-others 'drh-mono-cream)"
		else
		    cp ~/.config/alacritty/gray.toml ~/.config/alacritty/colors.toml
		    gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Dark-Grey
		    emacsclient -e "(load-theme-disable-others 'drh-mono-gray)"
		fi
		;;
	esac
	;;
esac





	
