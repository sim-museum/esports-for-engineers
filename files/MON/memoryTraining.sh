#!/bin/bash

# install (if necessary) and run Brainworks memory trainer program 
# for improving memory.  A good memory is useful for playing bridge.
# web site: http://brainworkshop.sourceforge.net/download.html
# 

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	exit 1
fi
export WINEPREFIX="$PWD/WP"

if [ -d "$WINEPREFIX/drive_c/Program Files (x86)/Brain Workshop" ]
then
   cd "$WINEPREFIX/drive_c/Program Files (x86)/Brain Workshop"
   wine brainworkshop.exe 2>/dev/null 1>/dev/null
   clear
   cat Readme-instructions.txt
   printf "\n\n"
   exit 0
else 
   # install for the first time
   clear

if wine --version | grep "wine-6.0"; then
	clear
	printf "Version 6.0 of wine detected.\nFor installation, Brainworks requires wine version 7 or greater.\n\nFrom the esports-for-engineers directory, run \n\n./wine-experimental.sh\n\nto install wine 7.\n\nThen run this script again.\n\n"
	exit 0
fi

   echo "Installing brainworkshop; simply accept all defaults."
   echo ""
   wine "$WINEPREFIX/../INSTALL/brainworkshop-4.8.4-win32-setup.exe" 2>/dev/null 1>/dev/null
   clear
   cat "$WINEPREFIX/drive_c/Program Files (x86)/Brain Workshop/Readme-instructions.txt"
   printf "\n\nRun this script again to start the program\n\n"
   exit 0
fi
