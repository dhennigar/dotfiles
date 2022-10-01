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
