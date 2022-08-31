source ~/.aliases.sh
source ~/.bash-powerline.sh
export BASH_SILENCE_DEPRECATION_WARNING=1
export GPG_TTY=$(tty)
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

if [ ! -e "~/.wpe_aliases.sh" ]; then
  source ~/.wpe_aliases.sh
fi

if [ ! -e "~/.profile_local" ]; then
  source ~/.profile_local
fi;

# Add tab completion for many Bash commands
if [ -f "usr/local/etc/bash_completion" ]; then
  source "usr/local/etc/bash_completion"
fi;
