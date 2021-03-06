## .bash_aliases
## Masahiro Koga
# color option can't use in solaris
if [[ $OSTYPE == "linux-gnu" || $OSTYPE == "darwin10.0" ]]; then
alias ls='ls -F --color=auto'
fi
alias la='ls -lag'
alias l='ls -F'
alias emacs='emacs -geometry 80x30'
alias ec='emacsclient -c'
alias et='emacsclient -t'
alias ecn='emacsclient -t'
