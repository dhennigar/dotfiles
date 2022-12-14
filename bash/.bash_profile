#
# ~/.bash_profile
#

# shell environment variables
export PATH="$PATH:/home/dhenn/.local/bin"
export EDITOR="nvim"
export VISUAL="nvim-qt"
export TERMINAL="foot"

# Qt and wayland things
export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME=qt5ct

# alacritty hidpi
export WINIT_X11_SCALE_FACTOR=1.0
