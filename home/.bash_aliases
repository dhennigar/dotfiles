#
# ~/.bash_aliases
#

# Author: Daniel Hennigar
# Description: Useful command aliases for the bash scripting language.

### Paru package manager and AUR helper
alias paru='paru --skipreview'

### Quick and pretty directory lists
alias l='ls --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -a --color=auto'
alias lla='ls -la --color=auto'

### A nicer cat clone with syntax highlighting
alias cat='bat -P --theme=ansi --style=plain'

### Similar for grep
alias g='grep --color=auto'
alias grep='grep --color=auto'

### Quick text-editor access
alias m='mg'
alias vi='mg'

### Print useful info to the console with single characters
alias c='date "+%Y/%m/%d %H:%M"'
alias b='cat /sys/class/power_supply/BAT0/capacity && cat /sys/class/power_supply/BAT0/status'

### Forgiveness of typos or brain-farts
alias quit='exit'
alias exi='exit'
alias xit='exit'
alias clea='clear'
alias lear='clear'
alias cleear='clear'
alias cleaar='clear'


### Use mpv as an image viewer (it's not great)
alias mvi='mpv --config-dir=$HOME/.config/mvi'
