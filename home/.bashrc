#
# ~/.bashrc
#

# If shell is non-interactive, beat it.
if [[ $- != *i* ]] ; then
	return
fi

shopt -s checkwinsize		 # make shell window size aware
shopt -s no_empty_cmd_completion # tab on empty line does nothing
shopt -s autocd			 # preceding `cd' is optional

set -o noclobber		# fix some garbled output issues

rm() { command rm -i "${@}"; }	# ask before deleting
cp() { command cp -i "${@}"; }	# ask before copying
mv() { command mv -i "${@}"; }	# ask before moving


# If we are using a terminal emulator, set a nice prompt.
case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|interix|tmux*)
		PS1='\[\033]0;\u@\h:\w\007\]'
		;;
	screen*)
		PS1='\[\033_\u@\h:\w\033\\\]'
		;;
	*)
		unset PS1
		;;
esac

# If dircolors is available, or using a terminal emulator, we use colors
use_color=false
if type -P dircolors >/dev/null ; then
	LS_COLORS=
	if [[ -f ~/.dir_colors ]] ; then
		eval "$(dircolors -b ~/.dir_colors)"
	elif [[ -f /etc/DIR_COLORS ]] ; then
		eval "$(dircolors -b /etc/DIR_COLORS)"
	else
		eval "$(dircolors -b)"
	fi
	if [[ -n ${LS_COLORS:+set} ]] ; then
		use_color=true
	else
		unset LS_COLORS
	fi
else
	case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|screen|tmux|cons25|*color) use_color=true;;
	esac
fi

# If we are using colors (above), set a colorful prompt.
if ${use_color} ; then
	if [[ ${EUID} == 0 ]] ; then
		PS1+='\[\033[01;31m\]\h\[\033[01;34m\] \w \$\[\033[00m\] '
	else
		PS1+='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
	fi

	#BSD#@export CLICOLOR=1
	#GNU#@alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
else
	# show root@ when we don't have colors
	PS1+='\u@\h \w \$ '
fi

# Environment cleanup
unset use_color

# Use my custom aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Prompt to install missing package if command not found
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
    source /usr/share/doc/pkgfile/command-not-found.bash
fi

# Recommended integration for Emacs terminal emulator
vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}
if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    function clear() {
        vterm_printf "51;Evterm-clear-scrollback";
        tput clear;
    }
fi

if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
    exec sway
fi
