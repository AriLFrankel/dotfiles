#
# Aliases
#

#java
export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_211.jdk/Contents/Home'

# maven
export PATH=$PATH:/usr/local/bin/apache-maven-3.6.1/bin

# ts
export TF_AUTO_SAVE_CREDENTIALS='1'

# See symlinks in node_modules
alias links='ls -l node_modules | grep ^l'

# Conveniently edit vimrc
alias evim='vim ~/.vimrc'

# Conveniently edit bash_profile
alias eprof='vim ~/.profile'

# Conveniently try vim out on a scratch pad
alias scratch='vim ~/dotfiles/scratch.js'

# Common typos
alias vmi='vim'
alias gti='git'
alias sl='ls'

# Print out directory tree, but omit node_modules
alias lst='tree -a -I "node_modules|.git|.next"'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."

# mkcdir
mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# whichport
whichport ()
{
 sudo lsof -n -i :"$1" | grep LISTEN
}

gclone ()
{
  git clone "$1" && cd "$(basename "$1" .git)"
}

note ()
{
  vim "~/Documents/notes/$1"
}

# Shortcuts
alias desktop="cd ~/Desktop"
alias wip="cd ~/Desktop/wip"
alias wholefoods="cd ~/Desktop/wip/wholefoods"
alias innerview="cd ~/Desktop/wip/wholefoods/2020"
alias dotfiles="cd ~/dotfiles"
alias notes="cd ~/Documents/notes"

# give tab completion to complex git aliases
function _git_arc() {
  _git_branch
}

# recursive find and delete
deleteall ()
{
  find . -name "1" -type -f -delete
}


