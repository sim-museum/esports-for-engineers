#!/bin/bash

# install (if necessary) and run qplus Bridge program
# qplus bridge web site: https://www.q-plus.com/engl/home_f.htm
# this linux script file is from https://github.com/bencaddigan/esports-for-engineers
# on Ubuntu 20.04 LTS
# this requires issuing the following command:
# sudo apt install -y wine 
#
# demo download from https://www.q-plus.com/engl/download/download_f.htm
# 30 May 2020

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	exit 1
fi

export WINEPREFIX="$PWD/WP"

if [ -d "$WINEPREFIX/drive_c/games/qbridge15" ]
then
   # qplus bridge is already installed
   cd "$WINEPREFIX/drive_c/games/qbridge15"
   wine QBRIDGE.EXE 2>/dev/null 1>/dev/null
   cd "$WINEPREFIX/.."
   clear
   cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageQplus.txt"
   echo ""; echo ""
   exit 0
else 

if wine --version | grep "wine-6.0"; then
        clear
        printf "Version 6.0 of wine detected.\nFor installation, Qplus Bridge requires wine version 7 or greater.\n\nFrom the esports-for-engineers directory, run \n\n./wine-experimental.sh\n\nto install wine 7.\n\nThen run this script again.\n\n"
        exit 0
fi

   # install Qplus for the first time
   if [ -f "$WINEPREFIX/../INSTALL/qplus15-eng.exe" ]
   then
      clear
      echo "Installing Qplus Bridge for the first time; simply accept all defaults."
      echo ""
      wine "$WINEPREFIX/../INSTALL/qplus15-eng.exe" 2>/dev/null 1>/dev/null
      clear
      cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageQplus.txt"
      echo ""; echo ""   
      exit 0
   else
      echo " "; echo "To install Qplus Bridge, follow these steps:"
      echo "1. download  qplus15-eng.exe from https://www.q-plus.com/engl/download/download_f.htm"
      echo "2. copy the exe into the MON/INSTALL directory"
      echo "3. run this script again."; echo " "
   fi
fi
