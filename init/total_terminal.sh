#!/usr/bin/env bash

# Install TotalTerminal
echo "Installing TotalTerminal"
brew cask install totalterminal

echo "Configuring TotalTerminal"
defaults import com.apple.terminal $DIR/resources/com.apple.terminal.plist
