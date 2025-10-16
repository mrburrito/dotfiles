#!/usr/bin/env bash

function opt_brew() {
  local package="$1"
  local label="${2:-${package}}"

  read -p "Install ${label}? (y/n): " answer
  case "${answer}" in
    [Yy]* ) echo "Installing ${label}..."; brew install "${package}";;
    * ) echo "Skipping ${label}..."; return;;
  esac
}

opt_brew adobe-creative-cloud "Creative Cloud"

opt_brew parallels Parallels

opt_brew virtualbox VirtualBox

opt_brew transmit Transmit

opt_brew dosbox DosBox

opt_brew steam Steam

opt_brew microsoft-office "Microsoft Office"

opt_brew discord Discord
