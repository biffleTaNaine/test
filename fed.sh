#!/bin/bash

# Fedora post installation script

# Ensure distro is up to date
dnf update -y

# Install gnome minimal/core
dnf install gnome-core terminator zsh ufw whois dnsutils htop secure-delete gnome-shell-pomodoro transmission-gtk moka-icon-theme faba-icon-theme -y && dnf remove gnome-terminal rhythmbox totem cheese polari inkscape brasero gnome-dictionary gnome-user-guide gnome-packagekit empathy yelp gnome-weather gnome-contacts gnome-software gnome-online-miners gnome-sushi tracker gnome-calculator gnome-sushi vino && dnf clean -y

