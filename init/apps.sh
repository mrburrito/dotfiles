#!/usr/bin/env bash

echo "Installing TextMate"
TEXTMATE_URL=https://api.textmate.org/downloads/release
INSTALL_DIR=/tmp/textmate
DOWNLOAD=textmate.tbz

mkdir $INSTALL_DIR
/usr/bin/curl -L --fail -o $INSTALL_DIR/$DOWNLOAD $TEXTMATE_URL
cd $INSTALL_DIR && tar xf $DOWNLOAD && sudo mv TextMate.app /Applications
cd
rm -rf $INSTALL_DIR


echo "Installing MacDown"
brew cask install macdown


echo "Installing Chrome"
CHROME_URL=https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg
_download_dmg $CHROME_URL ${CHROME_URL##*/}


echo "Installing Firefox"
FFX_URL=`/usr/bin/curl -L https://getfirefox.com 2>&1 | grep -o -E 'href="([^"#]+)"' | cut -d'"' -f2 | grep "product=" | grep "os=osx" | head -n 1`
_download_dmg $FFX_URL Firefox.dmg

function _download_dmg {
	url=$1
	filename=$2
	local_file=/tmp/$2
	
	echo "Downloading ${url} => ${local_file}"
	curl -L --fail -o $local_file $url
	echo "Installing ${filename}"
	install_dir=/tmp/dmg_dl
	mkdir $install_dir
	hdiutil attach -quiet -mountpoint $install_dir $local_file
	sudo cp -r $install_dir/*.app /Applications
	hdiutil detach $install_dir
	rmdir $install_dir
	rm -f $local_file
}


echo "Installing Dropbox"


echo "Installing Google Drive"
