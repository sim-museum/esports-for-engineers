$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	exit 1
fi

export WINEPREFIX=$PWD/WP

if [ ! -d "$WINEPREFIX/drive_c/Papyrus/NASCAR Racing 2003 Season" ]
then
	clear
	printf "NR2003 not installed.  Run \n\n./NR2003.sh\n\nfirst to install it.\n\nThen run this script again if you want to install optional \n1960's cars and tracks.\n"
	exit 0
fi

clear
mv "$WINEPREFIX/../../../tar/n2003_nurburgring_1970_v1.0.exe" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../../tar/AD67_v1.0.exe" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

echo "Adding 1960's cars and tracks to NR2003."
printf "\n\nOptional:  Download the 1970 Nurburgring at this link\n\nhttps://www.theuspits.com/files/n2003/tracks/n2003_nurburgring_1970_v1.0.exe\n\nand place it in the NR2003/INSTALL directory.\nDownload the 67 sports cars mod at this link:\n\nhttps://www.theuspits.com/files/n2003/mods/AD67_v1.0.exe\n\nand also add it to the NR2003/INSTALL directory.\nPress CONTROL C now, add the Nurburgring and sports cars,\nand run this script again to include them in the car/track upgrade\n\nPress CONTROL C, or any other key to continue.\n\n"
read replyString
cd $WINEPREFIX/../INSTALL
 tar xzf NR2003_additionalCarsAndTracks.tar.gz 2>/dev/null 1>/dev/null
cd NR2003_additionalCarsAndTracks
printf "\nTracks:\nBrands Hatch\nBridgehamption\nDundrod\nMonaco\nRouen\nWatkins Glen 1964\nZandervoort\n"
rsync -a tracks/ "$WINEPREFIX/drive_c/Papyrus/NASCAR Racing 2003 Season/tracks/" 2>/dev/null 1>/dev/null

printf "\nAdding Grand National 1963 cars\n"
cp -r gn63 "$WINEPREFIX/drive_c/Papyrus/NASCAR Racing 2003 Season/series/"


cd $WINEPREFIX/../INSTALL
if [ -f n2003_nurburgring_1970_v1.0.exe ]
then
   echo "Adding Nurburgring track"
   wine n2003_nurburgring_1970_v1.0.exe 2>/dev/null 1>/dev/null
fi

if [ -f AD67_v1.0.exe ]
then
   printf "Adding 1967 sports cars\n"
   wine AD67_v1.0.exe 2>/dev/null 1>/dev/null
fi


