#!/bin/bash

dots="~/Source/dotfiles"

mkdir -p ~/.config
mkdir -p ~/.mg.d

ln -sf $dots/home/bashrc ~/.bashrc
ln -sf $dots/home/bash_aliases ~/.bash_aliases
ln -sf $dots/home/profile ~/.profile
ln -sf $dots/home/mg ~/.mg

ln -sf $dots/config/sway ~/.config/
ln -sf $dots/config/mako ~/.config/
ln -sf $dots/config/fuzzel ~/.config/
ln -sf $dots/config/gammastep ~/.config/
ln -sf $dots/config/kanshi ~/.config/
ln -sf $dots/config/alacritty ~/.config/
