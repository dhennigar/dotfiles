#!/bin/bash

# Autostart file for Sway Wayland Compositor
# Daniel Hennigar

systemctl --user import-environment PATH
systemctl --user import-environment WAYLAND_DISPLAY

gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Base-Grey
gsettings set org.gnome.desktop.interface icon-theme Papirus
gsettings set org.gnome.desktop.interface font-name "IBM Plex Sans"
gsettings set org.gtk.Settings.FileChooser location-mode filename-entry

kanshi &
mako &
wl-paste --watch cliphist store &
gammastep &
emacs --daemon &
thunar --daemon &
batsignal -p &
