#!/bin/bash

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi

export WINEPREFIX=$PWD/WP
export MA_INSTALL=$PWD/INSTALL

if [ -f $WINEPREFIX/drive_c/rowan/mig/Mig.exe ]; then
    cd $WINEPREFIX/drive_c/rowan/mig
    wine Mig.exe 2>/dev/null 1>/dev/null
    exit 0
fi

numMonitors=$(eval "xrandr -q | grep connected | grep -v disconnected | wc -l")

if [ $numMonitors -ne 2 ]; then
	echo " "
	echo "To avoid graphics glitches, a dual monitor setup is recommended for Mig Alley."
	echo " "; echo "$numMonitors monitors were detected."; echo " "
        echo "To stop this script and set up dual monitors, press <CTRL> C."
	echo "To continue with your current monitor setup, press Enter"; echo " "
	read replyString
fi

if [ ! -f /usr/bin/winetricks ]; then
        echo " "; echo "ERROR: winetricks not found. This program is needed to install a wine library "
	echo "during Mig Alley installation.  If using Ubuntu 20.04 LTS install winetricks via:"
        echo "sudo apt install -y winetricks"; 
	echo " "
        exit 1
fi

if [ ! -f $MA_INSTALL/MA_iso/setup.EXE ]; then
    clear;
    echo "Before you can install Mig Alley, you must mount the Mig Alley iso."
    echo " "
    echo "Mount the Mig Alley CD-ROM iso using this command:"
    echo " "; echo "sudo mount -o loop $PWD/INSTALL/'Mig Alley V1.1.iso' $PWD/INSTALL/MA_iso"; echo " "
    echo "Then run this script again."
    exit 1
fi

# in Wine configuration Graphics tab unselect Allow the window manager to decoration the windows
clear; 
echo "In the Wine configuration dialog box, which appears next, select the 'Graphics' tab."
echo "Select Windows XP as the windows version."
echo "In the Graphics tab,  unselect 'Allow the window manager to decorate the windows'" 
echo "Then select OK to continue the installation."; echo " "
echo "Press enter to display the Wine configuration dialog box."
read replyString

winecfg 2>/dev/null 1>/dev/null

#echo " "; echo "Setting resolution on monitors to 1152x864 to avoid Mig Alley graphics problems";
#echo "If there are no graphics problems, you can increase monitor resolution later.";
#$MA_INSTALL/lowres.sh

winetricks vcrun6 2>/dev/null 1>/dev/null

wine $MA_INSTALL/MA_iso/setup.EXE 2>/dev/null 1>/dev/null
clear;
echo "Select 'CANCEL' in the DirectX(R) Setup dialog box, then press ENTER to continue.";
read replyString
clear;

echo "When Mig Alley starts, select PREFERENCES and set graphics resolution to the highest"
echo "resolution listed, which is probably 1152x864."
echo "Set all other graphics options to maximum values."
echo " "
wine $MA_INSTALL/Mig-Alley_Patch_Win_EN_Patch-123/MIG123.EXE 2>/dev/null 1>/dev/null
wine $MA_INSTALL/bdg_migalley_0.85f/BDG_MiGAlley_0.85F.exe 2>/dev/null 1>/dev/null
cp $MA_INSTALL/bdg.txt $WINEPREFIX/drive_c/rowan/mig 
cp -r $MA_INSTALL/MA_iso/smacker $WINEPREFIX/drive_c/rowan/mig
cp $MA_INSTALL/roots.dir $WINEPREFIX/drive_c/rowan/mig
cp $MA_INSTALL/SaveGame/*.* $WINEPREFIX/drive_c/rowan/mig/SaveGame
cp $MA_INSTALL/Videos/*.* $WINEPREFIX/drive_c/rowan/mig/Videos
# remap OUTSIDE REVERSE LOCK VIEW (view from opponents' aircraft) to CTRL F6
# because the default command, ALT F6, is used by Ubuntu to give a window keyboard focus
cp $MA_INSTALL/keys.xml $WINEPREFIX/drive_c/rowan/mig/KEYBOARD
rm $WINEPREFIX/drive_c/rowan/mig/mfc42.dll 2>/dev/null 1>/dev/null
cd $WINEPREFIX/drive_c/rowan/mig
wine Mig.exe 2>/dev/null 1>/dev/null

