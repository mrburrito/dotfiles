#!/usr/bin/env bash

# Java 6
brew cask install java6

# Java 7
brew cask install java7

# Java 8
brew cask install java

# Install Java Utils with Homebrew
brew install maven
brew install ant

# Configure Maven security settings from Dropbox
mkdir $HOME/.m2
ln -sf $HOME/Dropbox/.m2/settings-security.xml $HOME/.m2/settings-security.xml
if [ -f $HOME/Dropbox/.m2/settings-template.xml ]; then
	cp $HOME/Dropbox/.m2/settings-template.xml $HOME/.m2/settings.xml
fi

echo "Installing IntelliJ"
brew cask install intellij-idea
