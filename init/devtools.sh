#!/usr/bin/env bash

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

# Install git
brew install git

# Configure global ignores
$DIR/../bin/update_gitignore_global.sh
git config --global core.excludesfile $HOME/.gitignore_global

function _global_config {
	echo "Configuring global git settings"
	echo -n "Enter git user.name: "
	read name
	name=`echo -- $name`
	echo -n "Enter git user.email: "
	read email
	email=`echo -- $email`
	
	if [ ! -z "${name}" -a ! -z "${email}" ]; then
		echo "Setting git global settings to:"
		echo "\tuser.name: ${name}"
		echo "\tuser.email: ${email}"
		
		echo -n "Are these settings correct? [yN]: "
		read -n 1 correct
		if [ "$correct" == "y" -o "$correct" == "Y" ]; then
			git config --global user.name "$name"
			git config --global user.email "$email"
		else
			_global_config
		fi
	else
		echo "Name and email must be provided."
		_global_config
	fi
}
_global_config

# Install SourceTree
brew cask install sourcetree

# Java 7
brew cask install java7

# Java 8
brew cask install java

# Install Java Utils with Homebrew
brew install maven
brew install ant

# Configure Maven security settings from Dropbox
mkdir $HOME/.m2
if [ -f $HOME/Dropbox/.m2/settings-security.xml ]; then
	ln -sf $HOME/Dropbox/.m2/settings-security.xml $HOME/.m2/settings-security.xml
fi
if [ -f $HOME/Dropbox/.m2/settings-template.xml ]; then
	cp $HOME/Dropbox/.m2/settings-template.xml $HOME/.m2/settings.xml
fi

echo "Installing IntelliJ"
brew cask install intellij-idea-bundled-jdk

# Install SDKMan (formerly GVM)
echo "Installing SDK-Man"
curl -s http://get.sdkman.io | bash
source ~/.sdkman/bin/sdkman-init.sh

# Install the latest Groovy, Gradle and SpringBoot and make them the default
echo "Installing Groovy"
yes | sdk i groovy
echo "Installing Gradle"
yes | sdk i gradle
echo "Installing SpringBoot"
yes | sdk i springboot

# Install rbenv
echo "Installing rbenv"
brew install rbenv
echo "Installing ruby-build"
brew install ruby-build

echo "Installing RubyMine"
brew cask install rubymine-bundled-jdk

echo "Installing Node.js"
brew install node

echo "Installing Node Tools"
npm install -g grunt
npm install -g grunt-cli
npm install -g gulp
npm install -g gulp-load-plugins
npm install -g bower
npm install -g yo
npm install -g http-server
npm install -g swagger

echo "Installing WebStorm"
brew cask install webstorm-bundled-jdk

echo "Installing Python"
brew install python
brew install python3

echo "Installing PyCharm"
brew cask install pycharm-bundled-jdk
