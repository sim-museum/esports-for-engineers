$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	exit 1
fi

export WINEPREFIX=$PWD/WP

if [ -d "$WINEPREFIX/drive_c/Papyrus/NASCAR Racing 2003 Season" ]
then
	cd "$WINEPREFIX/drive_c/Papyrus/NASCAR Racing 2003 Season"
	wine NR2003.exe 2>/dev/null 1>/dev/null
	clear
	printf "NR2003 Optional Scripts:\n\nAdd additional 1960's era cars and tracks\n"$WINEPREFIX"/../additionalCarsAndTracks.sh\n\nChange NR2003 track parameters, AI, etc:\n"$WINEPREFIX"/../trackEditor.sh\n\n\n\nTip: always run NR2003 with the same version of wine\nthat was used to install it, to avoid an 'installation\nappears to be incorrect' error message.\n\n"
	exit 0
fi

mv "$WINEPREFIX/../../../tar/NASCAR-Racing-2003-Season_Win_EN_ISO-Version.zip" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../../tar/NASCAR-Racing-2003-Season_Fix_Win_EN_Fix-for-Version-1201.exe" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../../tar/NASCAR-Racing-2003-Season_Patch_Win_EN_Patch-1201.exe" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../../tar/NASCAR-Racing-2003-Season_NoCD_Win_EN.zip" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/NASCAR-Racing-2003-Season_Win_EN_ISO-Version.zip" ]
then
	clear
	echo "Nascar Racing 2003 install files not found in the directory TUE/NR2003/INSTALL"
	echo ""
	echo "From this link:"; echo ""
	echo "https://www.myabandonware.com/game/nascar-racing-2003-season-cox#download"
	echo ""
	echo "download the following 4 files:"
	echo "1. NASCAR-Racing-2003-Season_Win_EN_ISO-Version.zip"
	echo "2. NASCAR-Racing-2003-Season_Fix_Win_EN_Fix-for-Version-1201.exe"
	echo "3. NASCAR-Racing-2003-Season_Patch_Win_EN_Patch-1201.exe"
	echo "4. NASCAR-Racing-2003-Season_NoCD_Win_EN.zip"
	echo ""
	echo "Place these files in the TUE/NR2003/INSTALL directory."
	echo ""
	echo "Then run this script again."
	echo ""
	exit 0
else
        if [ -f "$WINEPREFIX/../isoMnt/autorun.exe" ] 
	then
		#iso mounted
		cd $WINEPREFIX/../isoMnt
		clear
		printf "In the Wine configuration dialog, in the Applications tab select Windows Version: Windows XP\nIn the Graphics tab, deselect Allow the window manager to decorate the windows,\nselect Emulate a virtual desktop,\nand set Desktop size to your monitor display resolution.\n\nPress a key to continue ...\n"
		winecfg 2>/dev/null 1>/dev/null
		read replyString
		printf "Installing NR2003\n\nSelect Install\nDo not select Register or look for updates\n\nWhen asked for a serial number, enter\nRAB2-RAB2-RAB2-RAB2-8869\nWrite down this serial number, as it will not be displayed on the screen during installation.\nPress a key to begin installation ...\n"
		read replyString

		wine autorun.exe 2>/dev/null 1>/dev/null
		clear
	        printf "\nPress a key to install the 1201 patch\n"
		read replyString
		cd $WINEPREFIX/../INSTALL
		wine NASCAR-Racing-2003-Season_Patch_Win_EN_Patch-1201.exe 2>/dev/null 1>/dev/null
		clear
                printf "\nPress a key to install the fix to 1201 patch\n"
		read replyString
		cp $WINEPREFIX/../INSTALL/Nascar_Racing_2003_Season_1201_NoCD/NR2003.exe "$WINEPREFIX/drive_c/Papyrus/NASCAR Racing 2003 Season"
		printf "\n Nascar Racing 2003 Season installed.  To install optional 1960's era cars and tracks in NR2003, run:\n\n"$WINEPREFIX"/../additionalCarsAndTracks.sh\n\nRun this script again to race.\n"
                  
		exit 0
	fi
       clear 
# unpack files	
        if [ ! -f "$WINEPREFIX/../INSTALL/NASCAR-Racing-2003-Season_Fix_Win_EN_Fix-for-Version-1201.exe" ]
	then 
		printf "INSTALL/NASCAR-Racing-2003-Season_Fix_Win_EN_Fix-for-Version-1201.exe missing\n\n"
		exit 0
	fi
        if [ ! -f "$WINEPREFIX/../INSTALL/NASCAR-Racing-2003-Season_NoCD_Win_EN.zip" ]
        then
                printf "NASCAR-Racing-2003-Season_NoCD_Win_EN.zip missing\n\n"
                exit 0
        fi

        if [ ! -f "$WINEPREFIX/../INSTALL/NASCAR-Racing-2003-Season_Patch_Win_EN_Patch-1201.exe" ]
        then
                printf "NASCAR-Racing-2003-Season_Patch_Win_EN_Patch-1201.exe missing\n\n"
                exit 0
        fi

        if [ ! -f "$WINEPREFIX/../INSTALL/NASCAR-Racing-2003-Season_Win_EN_ISO-Version.zip" ]
        then
                printf "NASCAR-Racing-2003-Season_Win_EN_ISO-Version.zip missing\n\n"
                exit 0
        fi

        clear
        echo "unpacking files"
	cd $WINEPREFIX/../INSTALL

	unzip NASCAR-Racing-2003-Season_Win_EN_ISO-Version.zip
	unzip NASCAR-Racing-2003-Season_NoCD_Win_EN.zip
	cd NASCAR_Racing_2003_Season_ISO
	bchunk Nascar_Racing_2003_Season.FLT.ShareReactor.BIN  Nascar_Racing_2003_Season.FLT.ShareReactor.CUE NR2003.iso
        mv NR2003.iso01.iso $WINEPREFIX/../INSTALL/NR2003.iso
	# use 32 bit wineprefix for trackEditor.sh
	WINEARCH=win32 wineboot
        printf "Cut and paste the commands below at a terminal prompt.\nDo not install mono, if prompted to do so:\n"
	cd $WINEPREFIX/../
	echo "export WINEPREFIX=\$PWD/WP"
	echo "winetricks vcrun2003 2>/dev/null 1>/dev/null"
	echo "sudo mount -o loop $WINEPREFIX/../INSTALL/NR2003.iso $WINEPREFIX/../isoMnt"
	printf "\nthen run this script again.\n"
fi
