#!/usr/bin/env bash

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

# Install git
brew install git

# Configure global ignores
${DIR}/../bin/update_gitignore_global.sh
git config --global core.excludesfile $HOME/.gitignore_global

function _global_config {
	echo "Configuring global git settings"
	read -p "Enter git user.name: " name
	read -p "Enter git user.email: " email

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
#brew cask install sourcetree

# Java 8
brew cask install java8

# Java 9
brew cask install java9

# Java 10
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
brew cask install intellij-idea
# Uncomment below to install IntelliJ Community Edition
#brew cask install intellij-idea-ce

# Install SDKMan
echo "Installing SDK-Man"
curl -s http://get.sdkman.io | bash
source ~/.sdkman/bin/sdkman-init.sh

# Install the latest Groovy, Gradle, SpringBoot, Scala, and SBT, and make them the default
echo "Installing Groovy"
yes | sdk i groovy
echo "Installing Gradle"
yes | sdk i gradle
echo "Installing SpringBoot"
yes | sdk i springboot
echo "Installing Scala"
yes | sdk i scala
echo "Installing SBT"
yes | sdk i sbt

# Install Scala 2.10
#SCALA210_HOME=/usr/local/share/scala-2.10
#mkdir -p /usr/local/{bin,share}
#wget -q http://downloads.lightbend.com/scala/2.10.6/scala-2.10.6.tgz -O /tmp/scala-2.10.6.tgz
#tar xzf /tmp/scala-2.10.6.tgz -C /usr/local/share
#ln -sf /usr/local/share/scala-2.10.6 $SCALA210_HOME
#for i in `ls $SCALA210_HOME/bin | grep -v bat`; do
#  ln -sf $SCALA210_HOME/bin/$i /usr/local/bin/${i}_210
#done
#rm -f /tmp/scala-2.10.6.tgz

# Install rbenv
echo "Installing rbenv"
brew install rbenv
echo "Installing ruby-build"
brew install ruby-build

#echo "Installing RubyMine"
#brew cask install rubymine

echo "Installing Node.js"
brew install node

echo "Installing Yarn"
brew install yarn

echo "Installing Angular CLI"
npm install -g @angular/cli

#npm install -g grunt
#npm install -g grunt-cli
#npm install -g gulp
#npm install -g gulp-load-plugins
#npm install -g bower
#npm install -g yo
#npm install -g http-server
#npm install -g swagger

#echo "Installing WebStorm"
#brew cask install webstorm

echo "Installing Python"
brew install python@2
brew install python

echo "Installing Cookiecutter and Pipsi"
PIPSI_HOME=${HOME}/.pipsi_local
PIPSI_BIN=${HOME}/bin
pip install pipsi
mkdir -p ${PIPSI_HOME} ${PIPSI_BIN}
pipsi --home=${PIPSI_HOME} --bin-dir=${PIPSI_BIN} install cookiecutter

#echo "Installing PyCharm"
#brew cask install pycharm
# Uncomment below to install PyCharm Community Edition
#brew cask install pycharm-ce

echo "Installing AWS CLI"
#pip3 install -U awscli
pipsi --home=${PIPSI_HOME} --bin-dir=${PIPSI_BIN} install awscli

echo "Installing Docker"
brew cask install docker
