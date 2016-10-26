#!/usr/bin/env bash

# Initializes a new Mac with common utilities

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Create ~/bin directory
mkdir ~/bin

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Install Cloud Sharing Apps
${DIR}/cloud.sh

# Install general utilities
${DIR}/utils.sh

# Install Miscellaneous Applications
${DIR}/apps.sh

# Install Browsers
${DIR}/browsers.sh

# Install dev tools
${DIR}/devtools.sh

# Link profile scripts
PROFILE_DIR=$(cd ${DIR}/../profile && pwd)
for file in ${PROFILE_DIR}/.*; do
	fname=${file##*/}
	test -f ~/${fname} && mv ~/${fname} ~/${fname}.dotfiles-backup
	ln -s ${file} ~/${fname}
done
ln -s ${PROFILE_DIR}/profile.d ~/.profile.d
test -f ~/.bashrc && mv ~/.bashrc ~/.bashrc.dotfiles-backup

# Update macOS Settings
${DIR}/macOS.sh

echo "Please restart once the installation script completes."

# Install ITerm2
echo "Installing ITerm2"
brew cask install iterm2

echo "Configuring Terminal"
defaults import com.apple.terminal ${DIR}/resources/com.apple.terminal.plist
if [[ -f ${HOME}/Dropbox/Apps/iterm2/com.googlecode.iterm2.plist ]]; then
    defaults import com.googlecode.iterm2 ${HOME}/Dropbox/Apps/iterm2/com.googlecode.iterm2.plist
else
    defaults import com.googlecode.iterm2 ${DIR}/resources/com.googlecode.iterm2.plist
fi
