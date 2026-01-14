#!/usr/bin/env bash

# Initializes a new Mac with common utilities

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Create bin directory and update path
mkdir -p "${HOME}/bin"
# Test if "${HOME}/bin" is on the path already and add it if not
if [[ ":${PATH}:" != *":${HOME}/bin:"* ]]; then
    export PATH="${HOME}/bin:${PATH}"
fi

# Install Homebrew
if ! which brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  export PATH="/opt/homebrew/bin:${PATH}"
fi
BREW_PREFIX="$(brew --prefix)"

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

LOCAL_PROFILE_DIR="${HOME}/.profile.d.local"
mkdir -p "${LOCAL_PROFILE_DIR}/login" "${LOCAL_PROFILE_DIR}/interactive"

if [[ ! -f "${LOCAL_PROFILE_DIR}/login/README.md" ]]; then
  cat <<'EOF' > "${LOCAL_PROFILE_DIR}/login/README.md"
Login shell includes only.

Place environment setup here that should apply to all login shells,
including non-interactive login sessions. Examples: PATH updates,
language toolchains (pyenv/nvm), shared environment variables, and
general utilities that should not assume an interactive prompt.
EOF
fi

if [[ ! -f "${LOCAL_PROFILE_DIR}/interactive/README.md" ]]; then
  cat <<'EOF' > "${LOCAL_PROFILE_DIR}/interactive/README.md"
Interactive shell includes only.

Place prompt setup, aliases, completions, and UI-oriented helpers here.
These scripts may assume an interactive terminal and should not be
required for non-interactive login sessions.
EOF
fi

LOCAL_PROFILE=${HOME}/.bash_profile.local
read -p "1Password Domain? " ONE_PASSWORD_DOMAIN
if grep "ONE_PASSWORD_DOMAIN=" ${LOCAL_PROFILE} >/dev/null; then
  sed -E "s/(export ONE_PASSWORD_DOMAIN=).*/\1${ONE_PASSWORD_DOMAIN}/" -i ${LOCAL_PROFILE}
else
  echo "export ONE_PASSWORD_DOMAIN=${ONE_PASSWORD_DOMAIN}" >>${LOCAL_PROFILE}
fi


# Update macOS Settings
${DIR}/macOS.sh

# Install ITerm2
echo "Installing ITerm2"
brew install iterm2

echo "Cleaning up..."
brew cleanup

echo "Configuring Terminal"
defaults import com.apple.terminal "${DIR}/resources/com.apple.terminal.plist"
if [[ -f "${HOME}/Dropbox/Apps/iterm2/com.googlecode.iterm2.plist" ]]; then
  defaults import com.googlecode.iterm2 "${HOME}/Dropbox/Apps/iterm2/com.googlecode.iterm2.plist"
else
  defaults import com.googlecode.iterm2 "${DIR}/resources/com.googlecode.iterm2.plist"
fi

echo "Please restart once the installation script completes."
