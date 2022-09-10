# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
alias :q='exit'
alias v='vim'
alias r='ranger'
alias t='htop'
alias ls='ls --color=auto'
alias la='ls -la --color=auto'
alias ll='ls -lah --color=auto'

# prompt
PS1='\w $ '

# shell environment variables
export PATH="$PATH:/home/dhenn/.local/bin"
export EDITOR="vim"
export VISUAL="vim"
export TERMINAL="alacritty"

# Qt and wayland things
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct

# Cursor settings
export XCURSOR_THEME="Simp1e-Nord-Light"
export XCURSOR_SIZE="16"

# GTK Settings
gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Simp1e-Nord-Light'
gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11'

# firefox
export MOZ_USE_WAYLAND=1
export GDK_BACKEND=wayland

# bemenu options
foreground='#AAAAFF'
background='#222233'
hilight='#5555FF'
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
	--bottom \
	--line-height 30 \
	--fn 'Noto Sans 10' \
	--prompt 'Run:'"

