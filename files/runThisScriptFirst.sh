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
        echo "This will make the 3D simulations run slowly or not at all."
        echo "To speed up graphics, install the proprietary drivers for your graphics card with these commands:"
        echo "sudo ubuntu-drivers devices"
        echo "sudo ubuntu-drivers autoinstall"
        echo ""
        echo "Next, reboot your computer and then run this script again."
        exit 1
    fi

fi

# Inform user about the upcoming package installations
echo -e "The following command will be executed to install Ubuntu packages needed by eSports for Engineers:\n"

# Display the list of packages to be installed
echo "sudo apt install -y wine-development winetricks vim okular liblua5.2-dev libqt5widgets5 scid stockfish xboard libopenblas-dev libqt5multimedia5 libqt5sql5 gnugo kigo python3-pip python3-pandas tenace deal dealer bchunk npm flightgear unrar 7zip dosbox sagemath"
echo "sudo npm install -g electron@10"
echo -e "\n\nInstalling these packages takes about 20 minutes.\n\n"

# Prompt user to proceed with the installation
echo -e "\n\nPress any key to install the packages\n\n"
read replyString

# Install required packages
time sudo apt install -y wine-development winetricks vim okular liblua5.2-dev libqt5widgets5 scid stockfish xboard libopenblas-dev libqt5multimedia5 libqt5sql5 gnugo kigo python3-pip python3-pandas tenace deal dealer bchunk npm flightgear unrar 7zip dosbox sagemath

# Install Electron via npm
time sudo npm install -g electron@28.0.0

# List of Packages and their Usage:

# MON:
#   bcalc: liblua5.2-dev libqt5widgets5, sagemath
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

