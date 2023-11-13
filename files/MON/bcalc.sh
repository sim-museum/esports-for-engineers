#!/bin/bash

# bcalc Bridge Calculator, running under linux with the windows version as a fallback
# bcalc web site: bcalc.w8.pl/
# this linux script file is from https://github.com/bencaddigan/esports-for-engineers
# for best quality graphics and speed, run the linux version of bcalc
# on Ubuntu 20.04 LTS
# this requires issuing the following command:
# sudo apt install -y wine liblua5.2-dev libqt5widgets5
#
# 30 Dec 2020

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi


export WINEPREFIX="$PWD/WP"
cd "$WINEPREFIX/../LINUX"
# simple BASH approximation to TRY/CATCH per
# https://stackoverflow.com/questions/22009364/is-there-a-try-catch-command-in-bash
# run the linux version of bcalcgui if it works, if not run the windows version under wine
# to activate the binary version in Ubuntu 20.04 LTS, issue this command:
# sudo apt install -y liblua5.2-dev libqt5widgets5

./bcalcgui 2>/dev/null 1>/dev/null || wine $WINEPREFIX/bcalcgui.exe 2>/dev/null 1>/dev/null 
clear
   cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageBcalc.txt"
   echo ""; echo ""   

exit 0
