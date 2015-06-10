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
if [ -d ~/Dropbox/.m2 ]; then
	mkdir ~/.m2
	ln -sf ~/Dropbox/.m2/settings-security.xml ~/.m2/settings-security.xml
	cp ~/Dropbox/.m2/settings-template.xml ~/.m2/settings.xml
fi

echo "Installing IntelliJ"
brew cask install intellij-idea
