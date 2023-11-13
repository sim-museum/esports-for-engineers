#!/usr/bin/bash
# this linux script file is from https://github.com/sim-museum/esports-for-engineers
# this script requires wine.  On Ubuntu 20.04 or 20.10, install wine via:
# sudo apt install -y wine

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi

export WINEPREFIX=$PWD/WP

if [ -f "$WINEPREFIX/drive_c/Program Files/GOG.com/Republic - The Revolution/Main/Republic/Exe/Republic.exe" ]
then
    cd "$WINEPREFIX/drive_c/Program Files/GOG.com/Republic - The Revolution/Main/Republic/Exe"
    wine Republic.exe 2>/dev/null 1>/dev/null
    exit 0
fi

mv "$WINEPREFIX/../../tar/Republic-The-Revolution_Win_EN.exe" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/drive_c/Program Files (x86)/GOG.com/Republic - The Revolution/Main/Republic/Exe/Republic.exe"  ]
then # open installation if clause
  if [ ! -f $WINEPREFIX/../INSTALL/Republic-The-Revolution_Win_EN.exe ]
  then
     clear
     echo "Republic: The Revolution is not installed."; echo ""
     echo "To install:"
     echo "1. Download Republic-The-Revolution_Win_EN.exe from"
     echo "https://www.myabandonware.com/game/republic-the-revolution-ck7#download"
     echo "2. copy Republic-The-Revolution_Win_EN.exe into the $WINEPREFIX/../INSTALL folder"
     echo "3. Run this script again"
     echo ""
     exit 0
  else
     clear
     echo "Installing ..."
     numMonitors=$(eval "xrandr -q | grep connected | grep -v disconnected | wc -l")

     if [ $numMonitors -ne 1 ]; then
        echo " "
        echo "$numMonitors monitors detected. To avoid graphics glitches in"
	echo "Republic: The Revolution, set your display settings to single monitor."
	echo "To change display settings now, press <CTRL> C.  To continue with the"
	echo "current monitor setup, press Enter:"
	read replyString
     fi # end if more than one monitor
     echo ""; echo "The optimal graphics resolution for Republic: The Revolution is 1152x864."
     echo "To change display settings now, press <CTRL> C.  To continue with the"
     echo "current monitor setup, press Enter:"
     read replyString

     clear;
     echo "In the Wine configuration dialog box, which appears next, select the 'Graphics' tab."
     echo "In the Graphics tab,  unselect 'Allow the window manager to decorate the windows'" 
     echo "Then select OK to continue the installation."; echo " "
     echo "Press enter to display the Wine configuration dialog box."
     read replyString

     WINEPREFIX=$WINEPREFIX WINEARCH=win32 wine wineboot

     winecfg 2>/dev/null 1>/dev/null
   fi # end else install file exists so perform install

     clear;
     echo "Now installing Republic: The Revolution.  In the Options menu, set all graphics"
     echo "settings to minimum."
     echo ""


     wine $WINEPREFIX/../INSTALL/Republic-The-Revolution_Win_EN.exe 2>/dev/null 1>/dev/null
     exit 0
fi # end if game not installed

# Republic: The Revolution is installed

