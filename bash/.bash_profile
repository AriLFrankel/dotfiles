source ~/.aliases.sh
source ~/.bash-powerline.sh

if [ ! -e "~/.wpe_aliases.sh" ]; then
  source ~/.wpe_aliases.sh
fi

if [ ! -e "~/.profile_local" ]; then
  source ~/.profile_local
fi

# Add tab completion for many Bash commands
if test $(which brew)
then
  brewdir=`brew --prefix`
  if [ -f "$brewdir/etc/bash_completion" ]; then
    source "$brewdir/etc/bash_completion"
  fi;
  unset brewdir
fi

