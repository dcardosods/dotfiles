#!/bin/zsh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew bundle

# Clone Prezto
git clone --recursive --branch runcoms git@github.com:dcardosods/prezto.git ${ZDOTDIR:-$HOME}/.zprezto

# Symlinks rumcoms from .zprezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Symlink the Mackup config file to the home directory
ln -s ${ZDOTDIR:-$HOME}/.dotfiles/.mackup.cfg ${ZDOTDIR:-$HOME}/.mackup.cfg

# Set macOS preferences
# We will run this last because this will reload the shell
# source .macos
