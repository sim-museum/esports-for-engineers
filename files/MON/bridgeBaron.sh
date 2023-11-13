#!/bin/bash

# install (if necessary) and run Bridge Baron Bridge program
# Bridge Baron web site: http://www.bridgebaron.com/
# this linux script file is from https://github.com/bencaddigan/esports-for-engineers
# on Ubuntu 20.04 LTS
# this requires issuing the following command:
# sudo apt install -y wine 
#
# demo download from https://www.greatgameproducts.com/download
# 30 May 2020

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	exit 1
fi

export WINEPREFIX="$PWD/WP"

if [ -d "$WINEPREFIX/drive_c/Program Files (x86)/Great Game Products/Bridge Baron 29" ]
then
   # Bridge Baron bridge is already installed
   wine "$WINEPREFIX/drive_c/Program Files (x86)/Great Game Products/Bridge Baron 29/Baron.exe" 2>/dev/null 1>/dev/null
   clear
   cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageBridgeBaron.txt"
   echo ""; echo ""
   exit 0
else 
   # install Bridge Baron for the first time
   if [ -f "$WINEPREFIX/../INSTALL/BB29WinEngDownload.exe" ]
   then
      clear
      echo "Installing Bridge Baron for the first time; simply accept all defaults."
      echo ""
      wine "$WINEPREFIX/../INSTALL/BB29WinEngDownload.exe" 2>/dev/null 1>/dev/null
      clear
      cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageBridgeBaron.txt"
      echo ""; echo ""   
      exit 0
   else
      echo " "; echo "To install Bridge Baron, follow these steps:"
      echo "1. download BB29WinEngDownload.exe from https://www.greatgameproducts.com/download"
      echo "2. copy the exe into the MON/INSTALL directory"
      echo "3. run this script again."; echo " "
   fi
fi
