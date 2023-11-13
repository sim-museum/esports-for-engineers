$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	exit 1
fi

export WINEPREFIX=$PWD/WP

if [ -f "$WINEPREFIX/drive_c/Program Files (x86)/Ubisoft/Chessmaster Grandmaster Edition/Chessmaster.exe" ]
then
	cd "$WINEPREFIX/drive_c/Program Files (x86)/Ubisoft/Chessmaster Grandmaster Edition"
	wine Chessmaster.exe 2>/dev/null 1>/dev/null

	clear
	printf "Chessmaster optional scripts\n\nConvert chessmaster output pgn into standard format:\nfixAnnotationsInChessmasterOutputPgnFile.sh\n\n"
	exit 0
fi

mv "$WINEPREFIX/../../../tar/Chessmaster-Grandmaster-Edition_Win_EN-FR.zip" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../../tar/Chessmaster-Grandmaster-Edition_Patch_Win_EN-FR_patch-v102.exe" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/Chessmaster-Grandmaster-Edition_Win_EN-FR.zip" ]
then
	clear
	echo "chessmaster install files not found in the directory $WINEPREFIX/../INSTALL/"
	echo ""
	echo "From this link:"; echo ""
	echo "https://www.myabandonware.com/game/chessmaster-grandmaster-edition-gra#download"
	echo ""
	echo "download the following 2 files:"
	echo "1. Chessmaster-Grandmaster-Edition_Win_EN-FR.zip" 
	echo "2. Chessmaster-Grandmaster-Edition_Patch_Win_EN-FR_patch-v102.exe" 
	echo ""
	echo "Place these files in the $WINEPREFIX/../INSTALL/ directory."
	echo ""
	echo "Then run this script again."
	echo ""
	exit 0
else        
	if [ ! -f "$WINEPREFIX/../INSTALL/itw-cge.iso" ]
	then
		echo "unpacking chessmaster iso file in WED/INSTALL/chessmaster"
		cd $WINEPREFIX/../INSTALL/
	unzip Chessmaster-Grandmaster-Edition_Win_EN-FR.zip
       	2>/dev/null 1>/dev/null
        	clear
		printf "To install chessmaster, run the following command in a terminal,\nthen run this script again.\n\nsudo mount -o loop "$WINEPREFIX"/../INSTALL/itw-cge.iso "$WINEPREFIX"/../INSTALL/isoMnt\n"
		exit 0
	fi

# unpack files	
     if [ -f "$WINEPREFIX/../INSTALL/isoMnt/Chessmaster Grandmaster Edition En/setup.exe" ]
     then
# iso mounted, not installed
                cd "$WINEPREFIX/../INSTALL/isoMnt/Chessmaster Grandmaster Edition En"
		clear
		printf "Chessmaster installation instructions:\n\n1. If asked wither to install Mono, do not install it.\n2. Do not install the Adobe pdf reader.  (clear the tic box next to Adobe).\n3. After Chessmaster is installed and the update dialog appears, exit from Chessmaster.\n\nPress a key to begin installation.\n\n"
		read replyString
		wine setup.exe 2>/dev/null 1>/dev/null
		cd $WINEPREFIX/../INSTALL/
		wine Chessmaster-Grandmaster-Edition_Patch_Win_EN-FR_patch-v102.exe 2>/dev/null 1>/dev/null
                printf "\nInstallation completed.  Run this script again to start Chessmaster.\n"
		exit 0
     fi
fi
