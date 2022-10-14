#
# ~/.bash_profile
#

# shell environment variables
export PATH="$PATH:/home/dhenn/.local/bin"
export EDITOR="nvim"
export VISUAL="nvim-qt"
export $HOSTNAME

# wayland or xorg autostart
case $XDG_SESSION_TYPE in
	x11)
		~/.local/bin/autostart-x11;;
	wayland)
		~/.local/bin/autostart-wl;;
esac

case $HOSTNAME in
	X200s)
		export TERMINAL="urxvt";;
	x230)
		export TERMINAL="alacritty";;
esac

# Qt and wayland things
export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME=qt5ct

# alacritty hidpi
export WINIT_X11_SCALE_FACTOR=1.0
