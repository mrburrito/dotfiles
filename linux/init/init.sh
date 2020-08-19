#!/usr/bin/env bash

# Initializes a new Linux workstation with common utilities

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

# Create ~/bin directory
mkdir ~/bin

# Link profile scripts
PROFILE_DIR=$(cd ${DIR}/../profile && pwd)
for file in ${PROFILE_DIR}/.*; do
	fname=${file##*/}
	test -f ~/${fname} && mv ~/${fname} ~/${fname}.dotfiles-backup
	ln -s ${file} ~/${fname}
done
ln -s ${PROFILE_DIR}/profile.d ~/.profile.d
test -f ~/.bashrc && mv ~/.bashrc ~/.bashrc.dotfiles-backup

LOCAL_PROFILE=${HOME}/.bash_profile.local
