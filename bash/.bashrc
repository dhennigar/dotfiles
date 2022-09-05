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

