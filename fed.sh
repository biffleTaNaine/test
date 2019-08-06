#!/bin/bash

# Fedora post installation script

# Ensure distro is up to date
dnf update -y

# add needed repositories


# Install gnome minimal/core
dnf install gnome-desktop3.x86_64 terminator zsh vim ansible virtualBox && dnf remove gnome-terminal rhythmbox totem cheese polari inkscape brasero gnome-dictionary gnome-user-guide gnome-packagekit empathy yelp gnome-weather gnome-contacts gnome-software gnome-online-miners tracker gnome-calculator vino tigervnc -y && dnf clean all
wget https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.rpm && rpm -ihv vagrant_*
