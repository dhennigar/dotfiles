#
# ~/.bash_profile
#

# shell environment variables
export PATH="$PATH:/home/dhenn/.local/bin"
export EDITOR="vim"
export VISUAL="vim"

# Qt and wayland things
export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME=qt5ct

# Cursor settings
export XCURSOR_THEME="plan9"
export XCURSOR_SIZE="16"

# GTK Settings
gsettings set org.gnome.desktop.interface gtk-theme 'Arc'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
gsettings set org.gnome.desktop.interface cursor-theme 'plan9'
gsettings set org.gnome.desktop.interface font-name 'Roboto 10'

# firefox
export MOZ_USE_WAYLAND=1
export GDK_BACKEND=wayland

# bemenu options
foreground='#AAAAAA'
background='#383c4a'
hilight='#5294E2'
export BEMENU_OPTS="\
        --tf $foreground \
        --tb $background \
        --nf $foreground \
        --nb $background \
        --af $foreground \
        --ab $background \
        --cf $hilight \
        --cb $background \
        --hf $background \
        --hb $foreground \
        --fb $background \
        --ff $foreground \
        --line-height 30 \
        --fn 'Noto Sans 11' \
        --prompt 'Run:'"
