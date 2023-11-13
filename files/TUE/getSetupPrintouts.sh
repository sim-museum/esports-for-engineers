#!/bin/bash

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi


export WINEPREFIX="$PWD/WP"

#copy briefing file to SAT directory

echo " "
echo "copying setups output from Setup Manager via File/export text file to TUE directory"
echo ""
cp $WINEPREFIX/drive_c/GPLSecrets/GPL\ Setup\ Manager/*.txt .
echo " "

