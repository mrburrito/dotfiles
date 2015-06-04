#!/usr/bin/env bash

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

# Install TotalTerminal
echo "Installing TotalTerminal"
TT_URL=`/usr/bin/curl -L -k https://totalterminal.binaryage.com/#installation 2>&1 | grep -o -E 'href="([^"#]+)"' | cut -d'"' -f2 | grep ".dmg" | head -n 1`
TT_FILE=${TT_URL##*/}
LOCAL_FILE=/tmp/$TT_FILE
echo "Downloading ${TT_URL} => ${LOCAL_FILE}"
/usr/bin/curl -L --fail -o $LOCAL_FILE $TT_URL

echo "Installing ${TT_FILE}"
INSTALL_DIR=/tmp/total_terminal
mkdir $INSTALL_DIR
hdiutil attach -quiet -mountpoint $INSTALL_DIR $LOCAL_FILE
package=$(ls $INSTALL_DIR/*.pkg)
sudo installer -pkg "$package" -target "/"
hdiutil detach $INSTALL_DIR
rmdir $INSTALL_DIR
rm -f $LOCAL_FILE

echo "Configuring TotalTerminal"
defaults import com.apple.terminal $DIR/resources/com.apple.terminal.plist
