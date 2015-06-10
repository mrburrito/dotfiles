#!/usr/bin/env bash

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

# Install git
brew install git

# Configure global ignores
$DIR/../bin/update_gitignore_global.sh
git config --global core.excludesfile ~/.gitignore_global

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
