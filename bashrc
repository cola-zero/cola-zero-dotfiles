## .bashrc
## Masahiro Koga

cd
# Source global definitions
if [ -f /etc/bash ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
## File/Directory mask bits.
## File: 644 (rw-r--r--)
## Directory: 755 (rwxr-xr-x)
umask   022

# Don't make core files
ulimit -c 0

# prompt
PS1='\[[\u@\h](\w)\$ '

# for macport
if [ $OSTYPE=="drawin9.0" ]; then
export PATH=/opt/local/sbin:/opt/local/bin:$HOME/local/bin:$PATH
elif [ $OSTYPE=="linux-gnu" ]; then
export PATH=$HOME/linux/local/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH
fi

# LANG Setting
if [ `uname`=='SunOS' ]; then
   export LNAG=ja;
elif [ `hostname`=='andLinux' ]; then
   export LANG=ja_JP.UTF-8;
fi

# about history
# history filename
HISTFILE=$HOME/.bash_history
# history size
HISTSIZE=100000
HISTFILESIZE=100000
# add history. don't override
shopt -s histappend
shopt -s histverify
shopt -s histreedit
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -f $HOME/.bash_aliases ]; then
   . ~/.bash_aliases
fi

# complete
shopt -s no_empty_cmd_completion
complete -d cd
complete -c man
complete -c which
complete -c whatis
complete -c sudo
if [ -f /opt/local/share/doc/git-core/contrib/completion/git-completion.bash ]; then
source /opt/local/share/doc/git-core/contrib/completion/git-completion.bash
fi

# set PAGER
if [ -f `which lv` ]; then
   export PAGER='lv -i'
   alias less='lv -s'
fi

# set EDITOR
export EDITOR="emacs -nw"

# lanch screen
#if [ -f `which screen` ]; then
#if [ $TERM != "screen" ]; then
#	exec screen -S main -xRR
#fi
#fi
