#!/bin/bash

################################################################################
# Ubuntu 22.04 LTS Installation Script for eSports for Engineers 22041 LTS
# This script provides commands to install necessary libraries and utilities
# required by some of the eSports for Engineers games.
#
# Author: [Sim Museum Curator]
# Date: [240520]
################################################################################

# Clear the terminal screen
clear

# Check if the system is running Ubuntu 2x.04 LTS
if [ $(cat /etc/issue | grep "Ubuntu 2"  | wc -c) -ne 0 ]; then

    # Check for Ubuntu 22.04 LTS installation bug which looks for apt packages on a CD-ROM
    if [ $(grep "^deb cdrom" /etc/apt/sources.list | wc -c) -ne 0 ]; then
        echo "WARNING: Ubuntu is set to install packages from a CD-ROM instead"
        echo "of the internet. To fix this, issue this command:"
        echo "sudo sed -i 's/deb cdrom/#deb cdrom/g' /etc/apt/sources.list"
        echo "then run this script again."
        exit 1
    fi

    # Check if proprietary graphics drivers are installed
    if [ $(lsmod | grep nouveau | wc -c) -ne 0 ]; then
        echo "WARNING: the slow open source nouveau graphics driver is installed."
        echo "This will make the 3D simulations run more slowly; TUE/rFactor/rFactor.sh and SAT/BMS/BMS35.sh may be unplayable."
        echo "To speed up graphics, install the proprietary drivers for your graphics card with these commands:"
	echo ""
        echo "sudo ubuntu-drivers devices"
        echo "sudo ubuntu-drivers autoinstall"
        echo ""
        echo "It is recommended to reboot your computer and run this script again after installing drivers -"
	echo "unless you have a mimimal graphics card (e.g. with 2GB of graphics memory).  In that case,"
	echo "nouveau is the best choice on ubuntu 24.04, as ubuntu 24.04 does not support older graphics drivers"
        echo ""
        read -p "Do you want to continue with the slower nouveau driver? (y/N): " response
        
        case $response in
            [Yy]* ) 
                echo "Continuing with nouveau driver..."
                ;;
            * )
                echo "Exiting script.  Install a proprietary graphics driver per instructions and rerun this script"
                exit 1
                ;;
        esac
    fi


fi
echo ""
echo "If using a proprietary graphics driver and graphics problems occur, consider downgrading to an older"
echo "graphics driver.  The latest ubuntu 24.04 graphics drivers may not work well with old 32 bit wine games"
echo ""

echo "If using an nvidia graphics card, type nvidia-smi to see which graphics driver is installed"
echo "If using the NVIDIA 550 driver, downgrade to the NVIDIA 535 driver for improved stability via:"
echo "sudo apt remove --purge '^nvidia-.*'"
echo "sudo apt autoremove"
echo "sudo apt install nvidia-driver-535"
echo "sudo reboot"
echo ""

# Inform user about the upcoming package installations
echo -e "The following command will be executed to install Ubuntu packages needed by eSports for Engineers:\n"

# Display the list of packages to be installed
echo "sudo apt install -y wine wine32:i386 winetricks wine64 vim okular liblua5.2-dev libqt5widgets5 scid stockfish xboard libopenblas-dev libqt5multimedia5 libqt5sql5 gnugo kigo python3-pip python3-pandas tenace deal dealer bchunk npm flightgear unrar 7zip dosbox python3.12-venv libgl1:i386 cmake build-essential libboost-all-dev qml-module-qtquick-shapes qml-module-org-kde-kcoreaddons filelight" 
echo -e "\n\nInstalling these packages takes about 20 minutes.\n\n"

# Prompt user to proceed with the installation
echo -e "\n\nPress any key to install the packages\n\n"
read replyString

# Install required packages

sudo dpkg --add-architecture i386
sudo apt update
time sudo apt install -y wine wine32:i386 winetricks wine64 vim okular liblua5.2-dev libqt5widgets5 scid stockfish xboard libopenblas-dev libqt5multimedia5 libqt5sql5 gnugo kigo python3-pip python3-pandas tenace deal dealer bchunk npm flightgear unrar 7zip dosbox python3.12-venv libgl1:i386 cmake build-essential libboost-all-dev qml-module-qtquick-shapes qml-module-org-kde-kcoreaddons filelight

# install python virtual environment

python3 -m venv ese_env

# install an earlier version of openssl for use by the linux native pip version of FRI/KaTrain, (another option is to run  KaTrain.exe with wine)
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb

# packages needed to build the poker hand evaluator SUN/ps-eval
sudo apt-get update && sudo apt-get install -y \
    git build-essential cmake clang ninja-build meson \
    protobuf-compiler libprotobuf-dev libopenblas-dev \
    zlib1g-dev libstdc++-14-dev wget

# obtain libzip5 library needed for FRI/katago
#
sudo dpkg -i libzip5_1.5.1-0ubuntu1_amd64.deb

# install lutris, for running some games that don't work under the default wine 9
 sudo apt install curl -y
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo bash /dev/stdin install deb-get
sudo deb-get install lutris
lutris --version

# activate this environment via
# source ese_env/bin/activate

# to build SUN/ps-eval:
#
# sudo apt install build-essential g++ cmake libboost-all-dev
# git clone https://github.com/andrewprock/pokerstove.git
# cd pokerstove
# mkdir build
# cd build
# cmake ..
# make
#
# To install lutris on ubuntu 24.04
# if a lutris build for ubuntu 24.04 is available:
# sudo add-apt-repository ppa:lutris-team/lutris
# sudo apt update
# sudo apt install lutris
# lutris
# alternative: install using flatpak
# sudo apt install flatpak
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpak install flathub net.lutris.Lutris
# flatpak run net.lutris.Lutris
#
# alterative: download from lutris github page
# wget https://github.com/lutris/lutris/releases/download/v0.5.13/lutris_0.5.13_all.deb
# sudo dpkg -i lutris_0.5.13_all.deb
# sudo apt --fix-broken install -y  # Resolve any missing dependencies
#
# alternative: download from lutris github page, with automatic updates
# sudo apt install curl -y
# curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo bash /dev/stdin install deb-get
# sudo deb-get install lutris
# lutris --version


# List of Packages and their Usage:

# MON:
#   bcalc: liblua5.2-dev libqt5widgets5.  Also need sagemath, which is not in the ubuntu 24.04 repo
#   Optional: tenace, deal
#
# TUE: None
#
# WED:
#   scid: scid stockfish
#   Optional: xboard, phalanx
#   nibbler: libopenblas-dev
#
# THU: Mig Alley: None
#
# FRI:
#   katago (used by sabaki, q5go): libopenblas-dev libzip5 libboost-filesystem-dev
#   q5go: libqt5multimedia5 libqt5sql5 gnugo
#   Optional: kigo, python3-pip
#
# SAT: None
#
# SUN: None
#
# Additional Useful Packages:
#   libreoffice, gwenview, gimp, kompare, winetricks, vlc

# Note: For graphics driver optimization, upgrade to faster drivers by following the instructions.
#       Ensure 'sudo lsmod | grep nouveau' returns no output after driver installation.

