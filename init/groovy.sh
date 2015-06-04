#!/usr/bin/env bash

# Install GVM
curl -s get.gvmtool.net | bash
source ~/.gvm/bin/gvm-init.sh

# Install the latest Groovy and Gradle and make them the default
yes | gvm i groovy
yes | gvm i gradle
