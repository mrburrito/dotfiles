#!/usr/bin/env bash

IGNORES=~/source/.gitignores
GLOBALS=${IGNORES}/Global
IGNORE_FILE=~/.gitignore_global

# Create a backup of the current ~/.gitignore_global if it exists
test -f ~/.gitignore_global && mv ~/.gitignore_global ~/.gitignore_global.bkp

# Clone https://github.com/github/gitignore.git if it does not exist; otherwise pull updates
echo "Updating gitignores from https://github.com/github/gitignore"
test -d ${IGNORES} && bash -c "cd ${IGNORES} && git pull"
test -d ${IGNORES} || git clone https://github.com/github/gitignore.git ${IGNORES}

for ignore in Archives Eclipse Emacs JetBrains MicrosoftOffice NetBeans macOS TextMate Vagrant Vim Xcode; do
	echo "Ignoring $ignore"
	cat ${GLOBALS}/${ignore}.gitignore >> ${IGNORE_FILE}
done
echo ".idea/" >> ${IGNORE_FILE}
