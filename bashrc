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
HISTFILE=$HOME/.bash_history
HISTSIZE=100000
HISTFILESIZE=100000
# add history. don't override
shopt -s histappend
shopt -s histverify
shopt -s histreedit
shopt -s checkwinsize

alias ls='ls -F'
alias la='ls -lag'

# complete
shopt -s no_empty_cmd_completion
complete -d cd
complete -c man
complete -c which
complete -c whatis
complete -c sudo
