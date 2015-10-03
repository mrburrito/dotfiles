#!/usr/bin/bash

# Install Cloud utilities

# Install Dropbox
echo "Installing Dropbox"
brew cask install dropbox

# Install Google Drive
echo "Installing Google Drive"
brew cask install google-drive

echo "Sign in to Dropbox and Google Drive"
read -p "Press [Return] when sync is complete..."
