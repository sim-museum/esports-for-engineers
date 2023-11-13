#!/bin/bash

# install (if necessary) and run wBridge5 Contract Bridge program
# wBridge5 web site: http://www.wbridge5.com/
# this linux script file is from https://github.com/bencaddigan/esports-for-engineers
# for best quality graphics and speed, run the linux version of bcalc
# on Ubuntu 20.04 LTS
# this requires issuing the following command:
# sudo apt install -y wine 
#
# 30 May 2020

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	exit 1
fi

export WINEPREFIX="$PWD/WP"

if [ -d "$WINEPREFIX/drive_c/wbridge5" ]
then
   # wBridge5 is already installed
   wine "$WINEPREFIX/drive_c/wbridge5/Wbridge5.exe" 2>/dev/null 1>/dev/null
   clear
   cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageWbridge5.txt"
   echo ""; echo ""
   exit 0
else 
   # install wBridge5 for the first time, make sure Windows XP emulation is selected in winecfg
   # otherwise the File/save and File/open commands won't work
   clear

if wine --version | grep "wine-6.0"; then
        clear
        printf "Version 6.0 of wine detected.\nFor installation, Omar Sharif Bridge requires wine version 7 or greater.\n\nFrom the esports-for-engineers directory, run \n\n./wine-experimental.sh\n\nto install wine 7.\n\nThen run this script again.\n\n"
        exit 0
fi

   
   echo "Installing Wbridge5 for the first time; simply accept all defaults."
   echo ""
#   echo "WARNING: With default setings, online help and file load and save don't work."
#   echo "run MON/setWineDisplayResolution.sh and set the windows emulation version to "
#   echo "Windows XP.  This will fix the to load and save problem."; echo ""
#   echo "Alternately, switch to the experimental version of wine via"
#   echo "wine_experimental.sh"
   echo "Install gecko when prompted."
   echo "this will cause online help, as well as file load and save, to work."; echo ""
   wine "$WINEPREFIX/../INSTALL/Wbridge5_setup.exe" 2>/dev/null 1>/dev/null
   clear
   cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageWbridge5.txt"
   echo ""; echo ""   
   exit 0
fi
