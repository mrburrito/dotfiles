#!/usr/bin/env bash

# Initializes a new Linux workstation with common utilities

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

# Create ${HOME}/bin directory
mkdir ${HOME}/bin

# Link profile scripts
PROFILE_DIR=$(cd ${DIR}/../profile && pwd)
for file in ${PROFILE_DIR}/.*; do
	fname=${file##*/}
	test -f ${HOME}/${fname} && mv ${HOME}/${fname} ${HOME}/${fname}.dotfiles-backup
	ln -s ${file} ${HOME}/${fname}
done
ln -s ${PROFILE_DIR}/profile.d ${HOME}/.profile.d
