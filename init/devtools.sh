#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

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

# Java Current (Zulu Arm64 Build)
brew install zulu

echo "Installing IntelliJ"
brew install intellij-idea

echo "Installing VSCode"
brew install visual-studio-code

# Install SDKMan
echo "Installing SDK-Man"
curl -s http://get.sdkman.io | bash
source ~/.sdkman/bin/sdkman-init.sh

# Install the latest Groovy, Gradle, SpringBoot, Scala, and SBT, and make them the default
echo "Installing Groovy"
yes | sdk i groovy
echo "Installing Gradle"
yes | sdk i gradle

echo "Installing nvm; defaulting node to latest LTS release"
brew install nvm
source "${BREW_PREFIX}/opt/nvm/nvm.sh"
nvm alias default "lts/*"

echo "Installing Angular CLI"
npm install -g @angular/cli

echo "Installing pyenv"
brew install pyenv
eval "$("${BREW_PREFIX}/bin/pyenv" init -)"

latest_stable_python="$(pyenv install --list | grep -E '^\s*[0-9]+\.[0-9]+\.[0-9]+\s*$' | grep -Po '\s*\K\d+\.\d+' | sort -uV | tail -n 1)"
echo "Setting default python version to latest stable version: ${latest_stable_python}"
pyenv install --skip-existing "${latest_stable_python}"
pyenv global "${latest_stable_python}"

echo "Installing pipx"
brew install pipx

echo "Installing pre-commit"
brew install pre-commit

echo "Installing AWS CLI"
brew install awscli

echo "Installing Docker"
brew install docker

echo "Installing Go"
brew install go \
	golangci-lint

git config --global alias.root 'rev-parse --show-toplevel'
