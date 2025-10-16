#!/usr/bin/env bash

# Installs common brew packages

# Install GNU Linux Utilities
brew install coreutils \
			 moreutils \
			 findutils \
			 gnu-sed
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install Bash 5
brew install bash \
			bash-completion@2
sudo cat >>/etc/shells <<EOF
/usr/local/bin/bash
EOF

# Install utiltiies
brew install wget \
			 tree \
			 gpg \
			 jq

if [[ -f "${HOME}/Dropbox/.gnupg" ]]; then
	ln -sf "${HOME}/Dropbox/.gnupg" "${HOME}/.gnupg"
fi

# Install 1Password
brew install 1password \
			 1password-cli

# Install ChatGPT
brew install --cask chatgpt
