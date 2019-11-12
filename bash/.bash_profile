source ~/.profile
source ~/.profile_local
source ~/.aliases.sh
source ~/.bash-powerline.sh
source ~/.git-completion.sh

# TODO make sure this file exists
if [ ! -e "~/.profile_local" ]; then
  source ~/.profile_local
fi
# added by Anaconda3 2019.03 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

# Add tab completion for many Bash commands
if test $(which brew)
then
  brewdir=`brew --prefix`
  if [ -f "$brewdir/etc/bash_completion" ]; then
    source "$brewdir/etc/bash_completion"
  fi;
  unset brewdir
fi

