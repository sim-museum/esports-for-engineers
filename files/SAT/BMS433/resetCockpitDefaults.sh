#!/usr/bin/bash
# this linux script file is from https://github.com/sim-museum/esports-for-engineers
# for best quality graphics and speed, run the linux version of bcalc
# on Ubuntu 20.04 this requires issuing the following command:
# sudo apt install -y wine
#
# 27 Dec 2020


if [ ! -f /usr/bin/wine ]; then
        echo " "
        echo "ERROR: wine not found.  Install wine 5 or later.  If using the recommended Ubuntu 20.04 LTS linux distribution,"
        echo "the command is:"
        echo "sudo apt install -y wine"
        echo "for more information, see https://wiki.winehq.org/Download"
        echo "Note: wine is the MS Windows emulation layer for linux.  It runs MS Windows programs under linux."
        echo " "
        exit 1
fi




if  wine --version | grep "wine-3";  then
        echo " "
        echo "ERROR: wine version 3 found, but wine version 5 or later is required for esports-for-engineers_3_0."
        echo "Uninstall wine, then download wine 5 using the instructions at https://wiki.winehq.org/Download"
        echo " "
        exit 1
fi

if  wine --version | grep "wine-4";  then
        echo " "
        echo "ERROR: wine version 4 found, but wine version 5 or later is required for esports-for-engineers_3_0."
        echo "Uninstall wine, then download wine 5 using the instructions at https://wiki.winehq.org/Download"
        echo " "
        exit 1
fi


export WINEPREFIX="$PWD/WP"
# initialize cockpit settings: callsign is Viper
cp $WINEPREFIX/../INSTALL/Viper.ini "$WINEPREFIX/drive_c/Falcon BMS 4.33 U1/User/Config"
exit 0


