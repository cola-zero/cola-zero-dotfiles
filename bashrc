## .bashrc
## Masahiro Koga

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
PS1='\[\033k\033\\\][\u@\h](\W)\$ '

# for macport
if [ $OSTYPE == "darwin10.0" ]; then
export PATH=$HOME/opt/sbin:$HOME/opt/bin:$HOME/local/bin:$PATH
elif [ $OSTYPE == "linux-gnu" ]; then
export PATH=$HOME/linux/opt/screen-git/bin:$HOME/local/opt/firefox:$HOME/.cabal/bin:$HOME/local/bin:/opt/ruby19/bin:$HOME/linux/local/bin:/sbin:/usr/sbin:/usr/local/sbin:/$HOME/.gem/ruby/1.9.1/bin:/opt/ruby19/lib/ruby/gems/1.9.1:$HOME/.gem/ruby/1.8/bin:$PATH
fi

# LANG Setting
if [ `uname` == 'SunOS' ]; then
   export LNAG=ja;
elif [ `hostname` == 'andLinux' ]; then
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
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
export EDITOR="vim"

# lanch screen
#if [ -f `which screen` ]; then
#if [ $TERM != "screen" ]; then
#	exec screen -S main -xRR
#fi
#fi

bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
