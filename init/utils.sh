#!/usr/bin/env bash

# Installs common brew packages

# Install coreutils
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew install moreutils
brew install findutils
brew install gnu-sed --with-default-names

# Install Bash 4
brew install bash
sudo cat >> /etc/shells <<EOF
/usr/local/bin/bash
EOF
brew tap homebrew/versions
brew install bash-completion2

# Install 'wget' with IRI support
brew install wget --with-iri

# Install other useful binaries
brew install ack
brew install imagemagick --with-webp
brew install p7zip
brew install tree
brew install gpg
brew install jq

if [ -f $HOME/Dropbox/.gnupg ]; then
	ln -sf $HOME/Dropbox/.gnupg $HOME/.gnupg
fi

opcli() {
  echo "Installing 1Password CLI"
  OP_VERSION=0.4.1
  curl -sL -o /tmp/op_darwin_amd64_v${OP_VERSION}.zip https://cache.agilebits.com/dist/1P/op/pkg/v${OP_VERSION}/op_darwin_amd64_v${OP_VERSION}.zip
  pushd /tmp >/dev/null
  unzip op_darwin_amd64_v${OP_VERSION}.zip
  gpg --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22 2>/dev/null
  if ! gpg --verify op.sig op 2>/dev/null; then
    echo "Unable to install 1Password CLI -- Bad Signature"
    rm op
  else
    mkdir -p /usr/local/bin
    mv op /usr/local/bin
    echo "1Password CLI Signature Valid -- Installed op $(/usr/local/bin/op --version)"
  fi
  rm op_darwin_amd64_v${OP_VERSION}.zip op.sig
  popd >/dev/null
}

# Install 1Password CLI
opcli
