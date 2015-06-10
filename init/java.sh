#!/usr/bin/env bash

# Downloads and installs Apple JDK 1.6 and Oracle JDK 7 and 8

ORACLE_BASE_URL=http://download.oracle.com/otn-pub/java/jdk
JAVA7_URL=${ORACLE_BASE_URL}/7u79-b15/jdk-7u79-macosx-x64.dmg
JAVA8_URL=${ORACLE_BASE_URL}/8u45-b14/jdk-8u45-macosx-x64.dmg

function _install_java {
	url=$1
	filename=${url##*/}
	volume=${filename%.dmg*}
	local_file=/tmp/$filename
	
	echo "Downloading ${url} => ${local_file}"
	/usr/bin/curl -b 'oraclelicense=accept-securebackup-cookie' $url -L --fail -o $local_file
	
	echo "Installing ${filename}"
	install_dir=/tmp/java_install
	mkdir $install_dir
	hdiutil attach -quiet -mountpoint $install_dir $local_file
	package=$(ls $install_dir/*.pkg)
	sudo installer -pkg "$package" -target "/"
	hdiutil detach $install_dir
	rmdir /tmp/java_install
	rm -f $local_file
}

# Java 6
_install_java https://support.apple.com/downloads/DL1572/en_US/JavaForOSX2014-001.dmg

# Java 7
_install_java $JAVA7_URL

# Java 8
_install_java $JAVA8_URL

# Install Java Utils with Homebrew
brew install maven
brew install ant

# Configure Maven security settings from Dropbox
if [ -d ~/Dropbox/.m2 ]; then
	mkdir ~/.m2
	ln -sf ~/Dropbox/.m2/settings-security.xml ~/.m2/settings-security.xml
	cp ~/Dropbox/.m2/settings-template.xml ~/.m2/settings.xml
fi

echo "Opening IntelliJ Download Portal"
open https://www.jetbrains.com/idea/download/
