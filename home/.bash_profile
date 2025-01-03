# ~/.bash_profile

export LANG=en_CA.UTF-8

PATH=$HOME/.local/bin:$HOME/perl5/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH; export PATH;

PERL5LIB="/home/dh/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/dh/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/dh/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/dh/perl5"; export PERL_MM_OPT;

export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland

XDG_CACHE_HOME=$HOME/.cache
XDG_CONFIG_HOME=$HOME/.config
XDG_DATA_HOME=$HOME/.local/share
XDG_STATE_HOME=$HOME/.local/state

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"

export GRIM_DEFAULT_DIR=~/Pictures/Captures

export RESTIC_REPOSITORY=sftp:dhenn@192.168.1.71:/home/dhenn/backup
