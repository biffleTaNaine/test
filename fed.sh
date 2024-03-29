#!/bin/bash

# Fedora post installation script

# Ensure distro is up to date
dnf update -y

# add needed repositories


# Install gnome minimal/core
dnf install gnome-desktop3.x86_64 gdm terminator zsh vim ansible firefox evolution xclip gnome-tweaks.noarch libXScrnSaver libvirt-daemon-driver-vbox.x86_64 keepassx -y && dnf remove gnome-terminal rhythmbox totem cheese polari inkscape brasero gnome-dictionary gnome-user-guide gnome-packagekit empathy yelp gnome-weather gnome-contacts gnome-software gnome-online-miners tracker gnome-calculator vino tigervnc -y && dnf clean all
#wget https://download.virtualbox.org/virtualbox/6.0.10/VirtualBox-6.0-6.0.10_132072_fedora29-1.x86_64.rpm && rpm -ivh VirtualBox-6.0-6.0.10_132072_fedora29-1.x86_64.rpm
wget https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.rpm && rpm -ihv vagrant_*
wget https://github.com/VSCodium/vscodium/releases/download/1.36.1/codium-1.36.1-1562700284.el7.x86_64.rpm && rpm -ivh codium-1.36.1-1562700284.el7.x86_64.rpm

# start GDM at boot
systemctl enable gdm.service
systemctl set-default graphical.target
