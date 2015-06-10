#!/usr/bin/env bash

echo "Installing TextMate"
brew cask install textmate

echo "Installing MacDown"
brew cask install macdown

echo "Installing Chrome"
brew cask install google-chrome

echo "Installing Firefox"
brew cask install firefox

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

if [ -d ~/Dropbox/.gnupg ]; then
	ln -sf ~/Dropbox/.gnupg ~/.gnupg
fi
