#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Determine if we are in OSX (Linux is assumed otherwise)
case "$OSTYPE" in
  darwin*) isMac=true ;;
  *) isMac=false ;;
esac

# Check for brew and install it if missing
if test ! $(which brew)
then
  if [ "$isMac" = true ] ; then
    printf "\n>> Installing Homebrew...\n"
    yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    printf "\n>> Installing Linuxbrew...\n"
    sudo apt-get install build-essential curl file git python-setuptools
    yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  fi
fi

# Make sure we’re using the latest Homebrew.
printf "\n>> Update Brew\n"
brew update

# Upgrade any already-installed formulae.
printf "\n>> Upgrade Brew\n"
brew upgrade

# Make not shallow
printf "\n>> Make homebrew not shallow\n"
git -C "$(brew --repo homebrew/core)" fetch --unshallow

printf "\n>> Install brew packages\n"
brew install yarn
brew install git
brew install stow
brew install vim --with-override-system-vi
brew install the_silver_searcher
brew install watchman
brew install zsh zsh-completions
brew install ack
brew install n
brew cask install google-chrome
brew cask install docker
brew cask install iterm2
brew cask install moom


# n requires resourcing or reloading before first use
source ~/.bash_profile

# Upgrade node
printf "\n>> Install Node LTS using n\n"
n lts

# Remove unused versions of node
n prune

# Install some global packages
printf "\n>> Install global npm packages\n"
npm i -g nodemon commitizen flow-bin eslint babel-eslint eslint-plugin-flowtype jest

# Skip least used installs
# brew install mongodb
# brew install postgresql
# brew cask install slack
# brew cask install whatsapp

# Install oh-my-zsh
  printf "\n>> Installing oh-my-zsh...\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Put my .zshrc back
 printf "\n>> Putting back the original .zshrc...\n"
[ -f ~/.zshrc.pre-oh-my-zsh ] && mv -f  ~/.zshrc.pre-oh-my-zsh ~/.zshrc

# Install fonts that will get used by iterm
  printf "\n>> Installing powerline fonts ...\n"
if [ ! -f ~/Library/Fonts/Meslo\ LG\ L\ Regular\ for\ Powerline.ttf ] ; then
  git clone https://github.com/powerline/fonts.git --depth=1
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts
fi

# Remove outdated versions from the cellar.
printf "\n>> Cleanup brew\n"
brew cleanup

printf "\n>> Check Brew health\n"
brew doctor

unset isMac
