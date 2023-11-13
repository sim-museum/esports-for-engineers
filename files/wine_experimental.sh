#!/bin/bash

# if not using the recommended distro (Ubuntu 22.04 LTS) then need to 
# add the winehq repository
# this is not ideal, because the experimental version is regularly
# updated, thus you'll be using a new version that has not been
# tested with esports-for-engineers
# it will probably work, however

if [ $(cat /etc/issue | grep "Ubuntu 22.04" | wc -c) -eq 0 ]
then
  echo "If you have already added the winehq-staging repository, copy and past the following line:"
  echo "sudo apt install --install-recommends winehq-staging"; echo " "
  echo "If you haven't, first add the repository"
  echo "# by copy/pasting the following commands one by one into a terminal window"
  echo "(reference: https://wiki.winehq.org/Ubuntu)"; echo " "

  echo "sudo dpkg --add-architecture i386"
  echo "wget -nc https://dl.winehq.org/wine-builds/winehq.key"
  echo "sudo apt-key add winehq.key"
  echo "sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ jammy main'"
  echo "sudo apt update"
  echo "sudo apt install --install-recommends winehq-staging"; 
  echo "sudo winetricks --self-update"
  echo " "
  echo "Choose install gecko (the wine help html reader) if prompted to do so."
  echo "when installing a game."
exit 0
fi

./wine7_2204LTS.sh
exit 0

