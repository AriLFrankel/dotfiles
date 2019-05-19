# Dotfiles

```
# clone repo and all submodules to home directory
$ cd ~/
$ git clone --recurse-submodules https://github.com/arilfrankel/dotfiles.git ~/dotfiles

# Stow
$ cd ~/dotfiles

$ stow bash git iterm profile vim zsh

# Install
$ cd ~/dotfiles

$ bash scripts/install.sh

quit and restart terminal

resources

[helpful article about stow](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
[Nathan's Dotfiles](http://github.com/nathan-schwartz/dotfiles)
```
