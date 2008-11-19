## .bashrc
## Masahiro Koga

# 新しいファイルは 644 で作成
umask 022

# do'nt make core file
ulimit -c 0

# prompt
PS1='\[\e[01:33m\][\u@\h]\[\e[0m\]\[\e[00:32m\](\w)\[\e[0m\]$ '

# for macport
if [ $OSTYPE == drawin* ]; then
export PATH=/usr/local/bin:$PATH 
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
