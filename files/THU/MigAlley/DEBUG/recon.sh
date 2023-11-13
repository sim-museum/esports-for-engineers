export WINEPREFIX=$PWD/WP
clear
echo "Use this script to view a recon photo on the 2D campaign screen."
echo "viewing a recon photo will cause the mouse and keyboard to become unresponsive (a hang)"
echo "As a workaround, this script will automatically cause Mig Alley to exit after 30 seconds."
echo "and reset the graphics on your primary display to its default value."
echo ""
echo "first, make sure emulate a virtual desktop is turned OFF on the Graphics tab ..."
winecfg
cd $WINEPREFIX/drive_c/rowan/mig/
wine Mig.exe 2>/dev/null 1>/dev/null &
# wait 30 seconds
sleep 30
# kill the wine server
wineserver -k
# reset the display to its default resolution
xrandr -s 0
