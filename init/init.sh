#!/usr/bin/env bash

# Initializes a new Mac with common utilities

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew
./brew.sh

# Install TotalTerminal
./total_terminal.sh

# Install Miscellaneous Applications
./apps.sh

# Install Git
./git.sh

# Install Java and Java utils
./java.sh

# Install Groovy
./groovy.sh

# Install Ruby utils
./ruby.sh

# Link profile scripts
PROFILE_DIR=$(cd $DIR/../profile && pwd)
for file in $PROFILE_DIR/.*; do
	fname=${file##*/}
	test -f ~/$fname && mv ~/$fname ~/$fname.dotfiles-backup
	ln -s $file ~/$fname
done
ln -s $PROFILE_DIR/profile.d ~/.profile.d

# Update OS X Settings
./osx.sh
