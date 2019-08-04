#!/bin/bash

# User Post Install Script for Debian Linux
# Run me as 'root' user!

echo
echo '################################################'
echo '#                                              #'
echo '########### User Post Install Script ###########'
echo '#                                              #'
echo '################################################'
echo
echo

instpkgs=('curl' 'gnupg' 'apt-transport-https')
esspkgs=('intel-microcode' 'firmware-iwlwifi' 'gnome-core' 'ufw' 'privoxy' 'whois' 'dnsutils' 'git' 'smartmontools' 'terminator' 'htop' 'wipe' 'nwipe' 'chkrootkit' 'rkhunter' 'lynis' 'xclip' 'keepassx' 'mat2' 'bleachbit' 'filezilla' 'gnome-shell-pomodoro' 'vlc' 'transmission-gtk' 'nodejs' 'moka-icon-theme' 'faba-icon-theme' 'network-manager-openvpn' 'network-manager-openvpn-gnome')
rempkgs=('gnome-terminal' 'rhythmbox' 'totem' 'cheese' 'polari' 'inkscape' 'brasero' 'gnome-dictionary' 'gnome-user-guide' 'gnome-packagekit' 'empathy' 'yelp' 'gnome-weather' 'gnome-contacts' 'gnome-software' 'gnome-online-miners' 'gnome-sushi' 'tracker' 'gnome-calculator' 'gnome-sushi' 'vino')

printf 'Check if required packages are installed...'

for instpkg in ${instpkgs[@]}; do
  if [[ $(dpkg-query -l "$instpkg") ]]; then
    echo 'required package' $instpkg 'found...'
  elif [[ $(dpkg-query -l "$instpkg") = 1 ]]; then
    echo 'required package' $instpkg 'not found! installing...'
    apt install -y $instpkg
    instError=$?
  elif [[ $instError -eq 1 ]]; then
    echo ' Error! Trying to fix...'
    apt --fix-broken install
    instError=$?
    if [[ $instError -eq 0 ]]; then
      echo 'Fixed! Script continues...'
    else
      echo 'Error! Script now halt!'
    fi
  fi
done

echo
echo 'Beginning stage 1'
echo
printf ' Configure 3rd party repositories? [Y/n] : '
read -r confRepo
echo

if [[ $confRepo = 'Y' ]] || [[ $confRepo = 'y' ]]; then
  printf 'Add "contrib" && "non-free" repositories? [Y/n] : '
  read -r cnf
  if [[ $cnf = 'Y' ]] || [[ $cnf = 'y' ]]; then
    if [[ $(grep -ci "$contrib" /etc/apt/sources.list) ]]; then
      echo '"contrib" && "non-free" repositories are already added to system!'
      echo
    else
      sed -i '/^deb/ s/$/ contrib non-free/' /etc/apt/sources.list
      success=$?
      if [[ $success -eq 0 ]]; then
        echo '"contrib" && "non-free" repositories successfully added to system!'
      fi
    fi
  fi

  printf 'Add "CISOfy" repositories? [Y/n] : '
  read -r cfy
  if [[ $cfy = 'Y' ]] || [[ $cfy = 'y' ]]; then
    if [[ -f /etc/apt/sources.list.d/cisofy-lynis.list ]]; then
      echo 'CISOfy repository is already added to system!'
      echo
    else
      curl -sL https://packages.cisofy.com/keys/cisofy-software-public.key | apt-key add -
      echo "deb https://packages.cisofy.com/community/lynis/deb/ stable main" | tee /etc/apt/sources.list.d/cisofy-lynis.list
      success=$?
      if [[ $success -eq 0 ]]; then
        echo 'CISOfy repository successfully added to system!'
      fi
    fi
  fi

  printf 'Add "NodeJS" repositories? [Y/n] : '
  read -r njs
  if [[ $njs = 'Y' ]] || [[ $njs = 'y' ]]; then
    if [[ -f /etc/apt/sources.list.d/nodesource.list ]]; then
      if [[ $(grep -ci "$node_8" /etc/apt/sources.list.d/nodesource.list) ]]; then
        #statements
        echo 'NodeJS 8.x repository is already added to system!'
        echo
      else
        echo 'NodeJS 9.x repository is already added to system!'
        echo
      fi
    else
      printf "Which version do you want to use? [8.x/9.x] : "
      read -r nversion
      case $nversion in
        "8.x" )
          curl -sL https://deb.nodesource.com/setup_8.x | bash -
          ;;
        "9.x" )
          curl -sL https://deb.nodesource.com/setup_9.x | bash -
          ;;
        *)
          echo "nothing"
          ;;
      esac
      success=$?
      if [[ $success -eq 0 ]]; then
        echo 'NodesJS ' $nversion ' repository successfully added to system!'
        echo
      fi
    fi
  fi

  # printf 'Add "Atom.io" repositories? [Y/n] : '
  # read -r aio
  # if [[ $aio = 'Y' ]] || [[ $aio = 'y' ]]; then
  #   if [[ -f /etc/apt/sources.list.d/atom.list ]]; then
  #     echo 'Atom.io repository is already added to system!'
  #   else
  #     curl -s https://packagecloud.io/install/repositories/AtomEditor/atom/script.deb.sh | bash
  #     #curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add -
  #     #echo "deb https://packagecloud.io/AtomEditor/atom/any/ any main" | tee /etc/apt/sources.list.d/atom.list
  #     success=$?
  #     if [[ $success -eq 0 ]]; then
  #       echo 'Atom.io official repository successfully added to system!'
  #     fi
  #   fi
  # fi

  printf 'Add "Slack" repositories? [Y/n] : '
  read -r asck
  if [[ $asck = 'Y' ]] || [[ $asck = 'y' ]]; then
    if [[ -f /etc/apt/sources.list.d/atom.list ]]; then
      echo 'Slack repository is already added to system!'
    else
      curl -sL https://packagecloud.io/install/repositories/slacktechnologies/slack/script.deb.sh | bash
      success=$?
      if [[ $success -eq 0 ]]; then
        echo 'Slack official repository successfully added to system!'
      fi
    fi
  fi
else
  echo 'Skipping 3rd party repositories'
fi

echo
echo 'Beginning stage 2'
echo
printf ' Configure worksation essential packages? [Y/n] : '
read -r confPkgs

if [[ $confPkgs = 'Y' ]] || [[ $confPkgs = 'y' ]]; then
  for esspkg in ${esspkgs[@]}; do
    if [[ $(dpkg-query -l "$esspkg") ]]; then
      echo 'required package' $esspkg 'found...'
    elif [[ $(dpkg-query -l "$esspkg") = 1 ]]; then
      echo 'required package' $esspkg 'not found! installing...'
      apt install -y $esspkg
      instError=$?
    elif [[ $instError -eq 1 ]]; then
      echo ' Error! Trying to fix...'
      apt --fix-broken install
      instError=$?
      if [[ $instError -eq 0 ]]; then
        echo 'Fixed! Script continues...'
      else
        echo 'Error! Script now halt!'
      fi
    fi
  done
else
  printf 'Skipping additional packages installation'
fi

echo
echo 'Beginning stage 3'
echo
printf ' Configure UFW firewall? [Y/n] : '
read -r confUFW

if [[ $confUFW = 'Y' ]] || [[ $confUFW = 'y' ]]; then
  printf ''
else
  printf 'Skipping firewall configuration'
fi

echo
echo 'Beginning stage 4'
echo
printf ' Is the configuration finished? [Y/n] : '
read -r confEnd

if [[ $confEnd = 'Y' ]] || [[ $confEnd = 'y' ]]; then
  echo 'updating, upgrading && removing unused packages'
  apt update && apt upgrade && apt remove $rempkgs && apt autoremove
else
  exit 1
fi

exit 0



function firewall() {
  status=$inStatus
  dest=$inDest
  port=$inPort
  protocol=$inProtocol
  return ufw $status $dest $port/$protocol
  ufw status verbose
}
