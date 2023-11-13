clear

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	exit 1
fi

export WINEPREFIX=$PWD/WP

if [ -f "$WINEPREFIX/Bridge Baron/Baron.exe" ]
then
	cd "$WINEPREFIX/Bridge Baron"
	wine Baron.exe 2>/dev/null 1>/dev/null
	clear
	exit 0
fi

mv "$WINEPREFIX/../../../tar/Bridge-Baron-12_Win_EN.zip" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/Bridge-Baron-12_Win_EN.zip" ]
then
	printf "Bridge-Baron-12_Win_EN.zip file not found in "$WINEPREFIX"/../INSTALL\n\nFrom \n\nhttps://www.myabandonware.com/game/bridge-baron-12-f44#download\n\nDownload this file:\n\nBridge-Baron-12_Win_EN.zip\n\nPlace this file in the "$WINEPREFIX"/../INSTALL directory,\n\nthen run this script again.\n\n\n"
	exit 0
fi

mv "$WINEPREFIX/../INSTALL/Bridge-Baron-12_Win_EN.zip" $WINEPREFIX
cd $WINEPREFIX
unzip Bridge-Baron-12_Win_EN.zip 2>/dev/null 1>/dev/null

clear
printf "In the wine configuration dialog box select Windows 98 for the windows version,\nthen in the graphics tab select virtual desktop, and enter a screen resolution, such as 800x600.\nDeselect allow the window manager to decorate the windows.\n\nPress any key to continue.\n\n\n"
read replyString

WINEARCH=win32 winecfg 2>/dev/null 1>/dev/null



clear
printf "\nBridge Baron 12 installed successfully.  Run this script again to play.\n\n"
exit 0

