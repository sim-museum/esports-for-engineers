# if you follow the installation and configuration instructions
# in introduction.txt, you are unlikely to have graphics 
# problems with Battle of Britain; read introduction.txt first!
# January 2021

export WINEPREFIX=$PWD/../WP
clear
echo "Debug Script for Battle of Britain Campaign"
echo "Use this script to test Battle of Britain campaign."
echo "Campaign may become unresponsive, depending on graphics"
echo "settings.  This script will cause BoB to exit after 60"
echo "seconds.  It is useful for testing different graphics"
echo "settings."
echo "use"
echo "xrandr -q"
echo "to identify your display name, for example HDMI-0"
echo "to restore your graphics settings after 60 seconds"
echo "add, e.g."
echo "xrandr --output HDMI-0 --mode 1280x1024"
echo "at the end of this script for best results"
echo "leaving all the graphics options unchecked can "
echo "produce the best results on the 2D campaign screen"
echo "but it is also most likely to hang or reset your display."
echo "all boxes checked, or all but manage screen, seems"
echo "to produce good results"
winecfg
cd "$WINEPREFIX/drive_c/Program Files/Rowan Software/Battle Of Britain"
wine bob.exe 2>/dev/null 1>/dev/null &
# wait 60 seconds
sleep 60 
# kill the wine server
wineserver -k
# reset the display to its default resolution
# replace "HDMI-0" in the line below with the
# name of your display as shown by 
# xrandr -q
# xrandr --output HDMI-0 --mode 1280x1024
xrandr -s 0
