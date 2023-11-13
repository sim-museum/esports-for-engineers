# for Ubuntu 20.04 LTS install
# recommended packages to install for eSports for Engineers version 4.1 
# this script gives you commands to type in a terminal window in
# order to install libraries needed by some of the esports for engineers games, as well as recommended utilities:

clear
if [ $(cat /etc/issue | grep "Ubuntu 2"  | wc -c) -ne 0 ]
then

# check for an Ubuntu 20.04 LTS installation bug which looks for apt packages on a CD rom
if [ $(grep "^deb cdrom" /etc/apt/sources.list | wc -c) -ne 0 ]
then
    echo "WARNING: Ubuntu is set to install packages from a cdrom instead"
    echo "of the internet.  To fix this, issue this command:"; echo ""
    echo "sudo sed -i 's/deb cdrom/#deb cdrom/g' /etc/apt/sources.list"; echo ""
    echo "then run this script again."
    exit 1
fi
# check that proprietary drivers are installed
if [ $(lsmod | grep nouveau | wc -c) -ne 0 ]
then
    echo "WARNING: the slow open source nouveau graphics driver is installed."
    echo "This will make the 3D sims run slowly or not at all."
    echo "To speed up graphics, install the proprietary drivers for your graphics card with these commands:"; echo ""
    echo "sudo ubuntu-drivers devices"
    echo "sudo ubuntu-drivers autoinstall"
    echo ""; echo "Next, reboot your computer and then run this script again."
    exit 1
fi

fi # end if using Ubuntu 20.04 LTS, Ubuntu 20.10 or Ubuntu 21.04

echo -e "The following command will be executed to install ubuntu packages\nneeded by esports-for-engineers\n\n"
echo "sudo apt install -y wine-development winetricks vim okular liblua5.2-dev libqt5widgets5 scid stockfish xboard libopenblas-dev libqt5multimedia5 libqt5sql5 gnugo kigo python3-pip python3-pandas tenace deal dealer eboard bchunk npm flightgear unrar 7zip dosbox freeplane"
echo "sudo npm install -g electron"
echo -e "\n\nInstalling these packages takes about 20 minutes.\n\n"

echo -e "\n\nPress a key to install the packages\n\n"

read replyString
time sudo apt install -y wine-development winetricks vim okular liblua5.2-dev libqt5widgets5 scid stockfish xboard libopenblas-dev libqt5multimedia5 libqt5sql5 gnugo kigo python3-pip python3-pandas tenace deal dealer eboard bchunk npm flightgear unrar 7zip dosbox
time sudo npm install -g electron
# http://www.matthew.ath.cx/projects/salliere/README
# sudo apt install -y gsalliere

# List of Packages and where they are used:
#
# general purpose
# wine-development vim okular
# note: the following optional packages require winehq-staging,
# which can be installed by running wine_experimental.sh:
# MON: not needed, but if using this version wBridge.sh in-game
# help becomes available
# TUE: rFactor 1
# THU: Rowan's Battle of Britain
# SAT: BMS 4.35
# SUN: Republic, The Revolution
# note: to switch back to wine-development, run the
# script wine_default.sh
#
# MON
# bcalc:
# liblua5.2-dev libqt5widgets5
#
# optional: tenace, deal
#
# TUE
# none
# run wine_experimental.sh before installing (optional) rFactor 1
#
# WED
# scid:
# scid stockfish 
# optional:
# xboard phalanx eboard
# nibbler:
# libopenblas-dev
# if using nvidia graphics card
# nvidia-opencl-dev
#
# THU
# Mig Alley:
# none
# optional, if playing Battle of Britain
# need to install a more recent version of wine as follows:
# wine 5.21 (Staging) or later is required to run Battle of Britain.
# install winehq-staging as described at this link: https://wiki.winehq.org/Ubuntu"
# For ubuntu 20.04, the commands are"
# sudo dpkg --add-architecture i386"
# wget -nc https://dl.winehq.org/wine-builds/winehq.key"
# sudo apt-key add winehq.key"
# sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'"
# sudo apt update"
# sudo apt install --install-recommends winehq-staging"
# note: every time you start a script for the first time with wine 5.21 (Staging)
# you will be asked whether you want to install mono and Gecko.
# for Battle of Britain, you need to install Gecko in order to use online help.
# for other games, save time by not installing Gecko, as you won't need it.
# always select "Cancel" when asked if you want to install mono - none of the
# games require mono, and it take a while to load.
#
# FRI
# katago, used by sabaki, q5go:
# libopenblas-dev libzip5 libboost-filesystem-dev
# q5go:
# libqt5multimedia5 libqt5sql5 gnugo
# optional:
# kigo python3-pip
# note you can install the latest version of KaTrain via the commands
# pip3 install katrain
# this installs katrain in ./local/bin, so you need to add that to your path:
# export PATH=$HOME/local/bin:$PATH
#
#SAT
# none
#
# useful for developing new content and documentation
# libreoffice gwenview gimp kompare winetricks vlc
# SUN
# glob2
#
# if 
# sudo lsmod | grep nouveau
# returns any output, then you are using the slow nouveau generic graphics driver.
# upgrade to a faster driver for your graphics card as follows:

# sudo ubuntu-drivers devices
# sudo ubuntu-drivers autoinstall
# reboot
# the following command should return no output, confirming that you
# are no longer using the generic nouveau graphics driver
# sudo lsmod | grep nouveau

