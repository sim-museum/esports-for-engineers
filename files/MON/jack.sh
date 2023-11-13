#!/bin/bash

# install (if necessary) and run jack Contract Bridge program
# wBridge5 web site: http://www.jackbridge.com/
# this linux script file is from https://github.com/bencaddigan/esports-for-engineers
# on Ubuntu 20.04 LTS
# this requires issuing the following command:
# sudo apt install -y wine 
#
# demo downloaded from http://jackbridge.com/eindex.htm
# 30 May 2020

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	exit 1
fi

export WINEPREFIX="$PWD/WP"

if [ -d "$WINEPREFIX/drive_c/Program Files/Jack 6 demo" ]
then
   # jack bridge is already installed
   wine "$WINEPREFIX/drive_c/Program Files/Jack 6 demo/jackdemo.exe" 2>/dev/null 1>/dev/null
   clear
   cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageJack.txt"
   echo ""; echo ""
   exit 0
else 
   # install jack for the first time
   clear
   echo "Installing jack bridge for the first time; simply accept all defaults."
   echo ""
   wine "$WINEPREFIX/../INSTALL/Setup-Jack-6-demo-ENG.exe" 2>/dev/null 1>/dev/null
   clear
   cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageJack.txt"
   echo ""; echo ""   
   exit 0
fi
