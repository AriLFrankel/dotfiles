#!/usr/bin/env bash

# # Ask for the administrator password upfront
sudo -v

# # Determine if we are in OSX (Linux is assumed otherwise)
case "$OSTYPE" in
  darwin*) isMac=true ;;
  *) isMac=false ;;
esac

# create a .profile_local file
touch ~/.profile_local

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

# # Make not shallow
printf "\n>> Make homebrew not shallow\n"
git -C "$(brew --repo homebrew/core)" fetch --unshallow

printf "\n>> Install brew packages\n"
brew install node
brew install yarn
brew install git
brew install stow
brew install vim --with-override-system-vi
brew install the_silver_searcher
brew install watchman
brew install ack
brew install tmux

printf "\n>> Install brew cask packages \n"
brew cask install google-chrome
brew cask install docker
brew cask install tableplus
brew cask install spotify
brew cask install slack
brew cask install whatsapp
brew cask install dotnet-sdk
brew cask install visual-studio-code

printf "\n>> Install vscode plugins \n"
code --install-extension sdras.night-owl
code --install-exntension peterjausovec.vscode-docker
code --install-extension steoates.autoimport
code --install-extension formulahendry.auto-close-tag
code --install-extension coenraads.bracket-pair-colorizer
code --install-extension christian-kohler.path-intellisense
code --install-extension esbenp.prettier-vscode
code --install-extension ms-vscode.vscode-typescript-tslint-plugin
code --install-exntension ms-vscode.csharp
code --install-exntension jchannon.csharpextensions
code --install-exntension jmrog.vscode-nuget-package-manager

printf "\n>> migrate vscode settings \n"
cp ../code/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
cp ../code/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json

# Install fonts that will get used by iterm
printf "\n>> Installing powerline fonts ...\n"
if [ ! -f ~/Library/Fonts/Meslo\ LG\ L\ Regular\ for\ Powerline.ttf ] ; then
  git clone https://github.com/powerline/fonts.git --depth=1
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts
fi

# Install some global packages
printf "\n>> Install global npm packages\n"
npm i -g n yarn nodemon flow-bin eslint babel-eslint eslint-plugin-flowtype  typescript

# Upgrade node
printf "\n>> Install Node LTS using n\n"
n lts

# Remove outdated versions from the cellar.
printf "\n>> Cleanup brew\n"
brew cleanup

printf "\n>> Check Brew health\n"
brew doctor

unset isMac
