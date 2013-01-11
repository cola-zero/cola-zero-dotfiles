#if running bash
if [ -n "$BASH_VERSION" ]; then
   # include .bashrc if it exists
   if [ -f "$HOME/.bashrc" ]; then
      . ~/.bashrc
   fi
fi

[[ -s "/Users/masahirokoga/.rvm/scripts/rvm" ]] && source "/Users/masahirokoga/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=$HOME/opt/bin:$PATH
