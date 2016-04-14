#!/usr/bin/env bash

# Initializes a new Mac with common utilities

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Install Cloud Sharing Apps
./cloud.sh

# Install general utilities
./utils.sh

# Install Miscellaneous Applications
./apps.sh

# Install Browsers
./browsers.sh

# Install dev tools
./devtools.sh

# Link profile scripts
PROFILE_DIR=$(cd $DIR/../profile && pwd)
for file in $PROFILE_DIR/.*; do
	fname=${file##*/}
	test -f ~/$fname && mv ~/$fname ~/$fname.dotfiles-backup
	ln -s $file ~/$fname
done
ln -s $PROFILE_DIR/profile.d ~/.profile.d
test -f ~/.bashrc && mv ~/.bashrc ~/.bashrc.dotfiles-backup

# Update OS X Settings
./osx.sh

echo "Please restart once the installation script completes."

echo "Configuring Terminal"
defaults import com.apple.terminal $DIR/resources/com.apple.terminal.plist
