apt update && apt install gnupg2 ; apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 ; sed -i '/^deb/ s/$/ contrib non-free/' /etc/apt/sources.list ; apt update && apt install gnome-core terminator ansible ufw whois dnsutils htop secure-delete xclip keepassx mat2 bleachbit filezilla gnome-shell-pomodoro vlc transmission-gtk moka-icon-theme faba-icon-theme -y && apt remove gnome-terminal rhythmbox totem cheese polari inkscape brasero gnome-dictionary gnome-user-guide gnome-packagekit empathy yelp gnome-weather gnome-contacts gnome-software gnome-online-miners gnome-sushi tracker gnome-calculator gnome-sushi vino && apt autoremove -y
