#!/usr/bin/env bash

# Installs Additional Browsers
#temp=$TMPDIR$(uuidgen)
#mkdir -p $temp/mount
#
#echo "Installing Chrome"
#curl https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg > $temp/1.dmg
#yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/1.dmg
#cp -r $temp/mount/*.app /Applications
#hdiutil detach $temp/mount
#rm -r $temp
#
#echo "Install Firefox manually..."
#open https://getfirefox.com
#read -p "Press [Return] key when done..."

echo "Installing Chrome"
brew cask install google-chrome

echo "Installing Firefox"
brew cask install firefox
