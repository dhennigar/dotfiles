#!/bin/bash

mkdir -p ~/.config
mkdir -p ~/.mg.d

ln -sf /home/dh/Source/dotfiles/home/bashrc ~/.bashrc
ln -sf /home/dh/Source/dotfiles/home/bash_aliases ~/.bash_aliases
ln -sf /home/dh/Source/dotfiles/home/profile ~/.profile
ln -sf /home/dh/Source/dotfiles/home/mg ~/.mg

ln -sf /home/dh/Source/dotfiles/config/sway ~/.config/
ln -sf /home/dh/Source/dotfiles/config/mako ~/.config/
ln -sf /home/dh/Source/dotfiles/config/fuzzel ~/.config/
ln -sf /home/dh/Source/dotfiles/config/gammastep ~/.config/
ln -sf /home/dh/Source/dotfiles/config/kanshi ~/.config/
ln -sf /home/dh/Source/dotfiles/config/alacritty ~/.config/
