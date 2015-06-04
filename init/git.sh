#!/usr/bin/env bash

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

# Install git
brew install git

# Configure global ignores
$DIR/../bin/update_gitignore_global.sh
git config --global core.excludesfile ~/.gitignore_global

function _global_config {
	echo "Configuring global git settings"
	echo -n "Enter git user.name: "
	read name
	echo -n "Enter git user.email: "
	read email
	
	if [ "${name}" != "" -and "${email}" != "" ]; then
		echo "Setting git global settings to:"
		echo "\tuser.name: ${name}"
		echo "\tuser.email: ${email}"
		
		echo -n "Are these settings correct? [yN]: "
		read -n 1 correct
		if [ "$correct" == "y" -or "$correct" == "Y" ]; then
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

# Install SourceTree
SOURCETREE_URL=`/usr/bin/curl -L https://www.sourcetreeapp.com/download 2>&1 | grep -o -E 'href="([^"#]+)"' | cut -d'"' -f2 | grep ".dmg"`
if [ "$SOURCETREE_URL" -ne "" ]; then
	SOURCETREE_DMG=${SOURCETREE_URL##*/}
	local_file=/tmp/$SOURCETREE_DMG
	
	echo "Downloading ${SOURCETREE_URL} => ${local_file}"
	/usr/bin/curl -L --fail $SOURCETREE_URL -o /tmp/$SOURCETREE_DMG
	
	echo "Installing ${SOURCETREE_DMG}"
	install_dir=/tmp/sourcetree_install
	mkdir $install_dir
	hdiutil attach -quiet -mountpoint $install_dir $local_file
	sudo cp -r $install_dir/SourceTree.app /Applications
	hdiutil detach $install_dir
	rmdir $install_dir
	rm -f $local_file
else
	echo "Unable to find SourceTree. Opening https://sourcetreeapp.com"
	open https://sourcetreeapp.com
fi
