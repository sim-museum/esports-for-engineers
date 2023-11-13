#!/bin/bash

# nibbler web site: https://github.com/fohristiwhirl/nibbler
# on Ubuntu 22.04 LTS this requires issuing the following command:
# sudo apt install -y wine libopenblass-dev
# the blass numerical library is used by lc0_cpu
# 29 Sep 2020

if [ ! -f /usr/bin/wine ]; then
        echo " "
        echo "ERROR: wine not found.  Install wine 5 or later.  If using the recommended Ubuntu 22.04 LTS linux distribution,"
        echo "the command is:"
        echo "sudo apt install -y wine"
        echo "for more information, see https://wiki.winehq.org/Download"
        echo "Note: wine is the MS Windows emulation layer for linux.  It runs MS Windows programs under linux."
        echo " "
        exit 1
fi

if  wine --version | grep "wine-3";  then
        echo " "
        echo "ERROR: wine version 3 found, but wine version 5 or later is required for esports-for-engineers_3_1."
        echo "Uninstall wine, then download wine 5 using the instructions at https://wiki.winehq.org/Download"
        echo " "
        exit 1
fi

if  wine --version | grep "wine-4";  then
        echo " "
        echo "ERROR: wine version 4 found, but wine version 5 or later is required for esports-for-engineers_3_1."
        echo "Uninstall wine, then download wine 5 using the instructions at https://wiki.winehq.org/Download"
        echo " "
        exit 1
fi

clear
echo "The first time you run the default leela chess zero front end, which is named nibbler,"
echo "you must specify the path to the lc0 chess engine. " 


export WINEPREFIX="$PWD/WP"

if [ ! -f /usr/local/bin/electron ]
then
	clear
	echo -e "electron not found.  Install it via\n\nsudo npm install -g electron\n\nthen run this script again.\n\n"
	exit 0
fi
#cd "$WINEPREFIX/../INSTALL/nibbler-1.5.4-linux"
# simple BASH approximation to TRY/CATCH per
# https://stackoverflow.com/questions/22009364/is-there-a-try-catch-command-in-bash
# run the linux version of nibbler if it works, if not run the windows version under wine
cd "$WINEPREFIX/../INSTALL/"

./lc0_cpu --help 2>/dev/null 1>/dev/null

returnCode=$?

# if libopenblas-dev or equivalent has been installed, then lc0_cpu is working, the return code is 0
# and the linux nibbler binary with linux lc0_cpu will work
# otherwise, run the windows version, which has (slightly) fuzzier graphics

if [ $returnCode -eq 0 ]; then
	echo "from the menu select Engine/Choose Engine"
	echo 'select (path)/WED/INSTALL/lc0_cpu'
	echo 'once you have selected lc0_cpu once, nibbler stores its location in ~/.config/Nibbler'
	echo 'so you do not have to enter this path again.'
	echo 'Optional: If you have a modern Nvidia GPU, you can run a faster version of lc0.'
	echo 'Optional: To do this in Ubuntu 22.04 LTS, first issue the command'
	echo 'Optional: sudo apt install -y nvidia-opencl-dev'
	echo 'Optional: then in the nibbler Engine/Choose Engine menu select'
	echo 'Optional: (path/WED/INSTALL/lc0_linux_graphicsAcceleration/lc0_opencl'
	echo 'If in doubt, start with the default lc0_cpu option as described above.'
	cd $WINEPREFIX/../INSTALL/nibbler/src
	electron . 2>/dev/null 1>/dev/null

#	./nibbler-2.3.1-linux/nibbler 2>/dev/null 1>/dev/null

#else
#	echo "from the menu select Engine/Choose Engine"
#	echo 'select $WINEPREFIX/drive_c/lc0_win/lc0.exe'
#	echo "if you are running wine Nibbler for the first time"
#wine "$WINEPREFIX/../INSTALL/nibbler-2.3.1-windows/nibbler.exe" 2>/dev/null 1>/dev/null
fi

#exit 0
