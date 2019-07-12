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
brew cask install tableplus
brew cask install spotify
# brew cask install slack
# brew cask install whatsapp

# .NET and VSCode
# brew cask install dotnet-sdk

# brew cask install visual-studio-code
# code --install-extension sdras.night-owl

# code --install-exntension ms-vscode.csharp
# code --install-exntension jchannon.csharpextensions
# code --install-exntension jmrog.vscode-nuget-package-manager

# code --install-exntension peterjausovec.vscode-docker

# code --install-extension mikael.angular-beastcode
# code --install-extension infinity1207.angular2-switcher
# code --install-extension steoates.autoimport

# code --install-extension formulahendry.auto-close-tag
# code --install-extension coenraads.bracket-pair-colorizer
# code --install-extension christian-kohler.path-intellisense
# code --install-extension esbenp.prettier-vscode
# code --install-extension ms-vscode.vscode-typescript-tslint-plugin


# cp ../code/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
# cp ../code/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json

# .NET and rider
# brew cask install rider
# brew install tee-clc
# printf "\033[1;31mPlease make sure to install Java SDK 8 here https://www.oracle.com/technetwork/java/javase/documentation/jdk8-doc-downloads-2133158.html and not latest version\033[0m\n";


# JS

# Install n for managing Node versions (using npm)
# printf "\n>> Install n\n"
# -y automates installation, -n avoids modifying bash_profile
# curl -L https://git.io/n-install | bash -s -- -n -y

# n requires resourcing or reloading before first use
# source ~/.bash_profile

# Upgrade node
# printf "\n>> Install Node LTS using n\n"
# n lts

# Remove unused versions of node
# n prune

# Install some global packages
# printf "\n>> Install global npm packages\n"
# npm i -g  yarn nodemon commitizen flow-bin eslint babel-eslint eslint-plugin-flowtype jest typescript angular-cli

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
