#
# ~/.bash_profile
#

# shell environment variables
export PATH="$PATH:/home/dhenn/.local/bin"
export EDITOR="nvim"
export VISUAL="nvim-qt"

# wayland or xorg autostart
case $XDG_SESSION_TYPE in
	x11)
		~/.local/bin/autostart-x11;
		export TERM=urxvt;;
	wayland)
		export TERM=foot;;
esac

# Qt and wayland things
export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME=qt5ct
