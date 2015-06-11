#!/usr/bin/env bash

echo "Installing TextMate"
brew cask install textmate

echo "Installing MacDown"
brew cask install macdown

BROWSER_DIR=$HOME/.cask_browsers
mkdir -p $BROWSER_DIR

echo "Installing Chrome"
brew cask install google-chrome --appdir=$BROWSER_DIR

echo "Installing Firefox"
brew cask install firefox --appdir=$BROWSER_DIR

# Cask installed Browsers do not work with 1Password; must move to /Applications
for browser in $BROWSER_DIR/*; do
	cp -Lr "$browser" "/Applications/${i##*/}"
fi

echo "Installing Creative Cloud"
brew cask install adobe-creative-cloud

echo "Installing Caffeine"
brew cask install caffeine

echo "Installing Adium"
brew cask install adium

echo "Installing Duet"
brew cask install duet

echo "Installing Google Drive"
brew cask install google-drive

echo "Installing Dropbox"
brew cask install dropbox

echo "Installing Logitech Control Center"
brew cask install logitech-control-center

echo "Installing Parallels"
brew cask install parallels-desktop

echo "Installing Vagrant"
brew cask install vagrant

echo "Installing Virtualbox"
brew cask install virtualbox

echo "Installing Sophos"
brew cask install sophos-anti-virus-home-edition

ln -sf $HOME/Dropbox/.gnupg $HOME/.gnupg
