$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	exit 1
fi

export WINEPREFIX=$PWD/WP

if [ ! -d "$WINEPREFIX/drive_c/Papyrus/NASCAR Racing 2003 Season" ]
then
	clear
	echo -e "Run ./NR2003.sh first, then run this script again.\n\n"
	exit 0
fi

if [ ! -f /usr/bin/winetricks ]
then
	clear
	echo -e "Install winetricks via\\nsudo install -y winetricks\n\nThen run this script again.\n\n"
	exit 0
fi

#install needed Visual Basic 6 runtime
winetricks vb6run 2>/dev/null 1>/dev/null

wine "$WINEPREFIX/../INSTALL/editorForNR2003/NR2003 Editor.exe" 2>/dev/null 1>/dev/null

