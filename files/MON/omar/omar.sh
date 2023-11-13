#clear

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	exit 1
fi

export WINEPREFIX=$PWD/WP

if [ -f "$WINEPREFIX/drive_c/Program Files/BRIDGE2/BR.EXE" ]
then
	cd "$WINEPREFIX/drive_c/Program Files/BRIDGE2"
	wine BR.EXE 2>/dev/null 1>/dev/null
	#clear
	exit 0
fi

mv "$WINEPREFIX/../../../tar/Bridge-Deluxe-2-With-Omar-Sharif_Win_EN_RIP-Version.zip" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/Bridge-Deluxe-2-With-Omar-Sharif_Win_EN_RIP-Version.zip" ]
then

if wine --version | grep "wine-6.0"; then
        ##clear
        printf "Version 6.0 of wine detected.\nFor installation, Omar Sharif Bridge requires wine version 7 or greater.\n\nFrom the esports-for-engineers directory, run \n\n./wine-experimental.sh\n\nto install wine 7.\n\nThen run this script again.\n\n"
        exit 0
fi

	printf "Bridge-Deluxe-2-With-Omar-Sharif_Win_EN_RIP-Version.zip file not found in "$WINEPREFIX"/../INSTALL.\nFrom \n\nhttps://www.myabandonware.com/game/bridge-baron-12-f44#download\n\nDownload this file:\n\nBridge-Deluxe-2-With-Omar-Sharif_Win_EN_RIP-Version.zip\n\nPlace this file in the "$WINEPREFIX"/../INSTALL directory,\n\nthen run this script again.\n\n"
	exit 0
fi

#clear
printf "In the wine configuration dialog box select Windows 95 for the windows version,\nthen in the graphics tab select virtual desktop, and enter a screen resolution, such as 800x600.\nUnselect allow the windows manager to decorate the window.\nSelect defaults during game install.\n\nPress any key to continue.\n\n"
read replyString

WINEARCH=win32 winecfg 2>/dev/null 1>/dev/null

mv "$WINEPREFIX/../INSTALL/Bridge-Deluxe-2-With-Omar-Sharif_Win_EN_RIP-Version.zip" "$WINEPREFIX/drive_c/Program Files"

cd "$WINEPREFIX/drive_c/Program Files"

unzip Bridge-Deluxe-2-With-Omar-Sharif_Win_EN_RIP-Version.zip 2>/dev/null 1>/dev/null
cd "$WINEPREFIX/drive_c/Program Files/BRIDGE2"
wine INSTALL.EXE 2>/dev/null 1>/dev/null

#clear
printf "\nOmar Sharif Bridge installed successfully.\nRun this script again to play.  If the menu bar\nis missing in the game press the ALT key to make it appear.  In-game videos are not working at present.\n\n"
exit 0

