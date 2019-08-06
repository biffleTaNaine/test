#!/bin/bash

# Fedora post installation script

# Ensure distro is up to date
dnf update -y

# Install gnome minimal/core
dnf install gnome-desktop3.x86_64 terminator zsh && dnf remove gnome-terminal rhythmbox totem cheese polari inkscape brasero gnome-dictionary gnome-user-guide gnome-packagekit empathy yelp gnome-weather gnome-contacts gnome-software gnome-online-miners tracker gnome-calculator vino tigervnc -y
