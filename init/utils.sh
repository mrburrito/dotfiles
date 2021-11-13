#!/usr/bin/env bash

# Installs common brew packages

# Install coreutils
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew install moreutils
brew install findutils
brew install gnu-sed

# Install Bash 4
brew install bash
sudo cat >> /etc/shells <<EOF
/usr/local/bin/bash
EOF
brew tap homebrew/versions
brew install bash-completion2

# Install 'wget' with IRI support
brew install wget

# Install other useful binaries
#brew install ack
#brew install imagemagick --with-webp
#brew install p7zip
brew install tree
brew install gpg
brew install jq

if [ -f $HOME/Dropbox/.gnupg ]; then
	ln -sf $HOME/Dropbox/.gnupg $HOME/.gnupg
fi

# Install 1Password
brew install 1password 1password-cli
