#!/usr/bin/bash
clear
echo "Before using sabaki, set up the computer Go engines by"
echo "install gnugo and the katago libraries."
echo ""
echo "Then calibrate katago to your computer."
echo "see installTips.pdf for details."

./INSTALL/sabaki-v0.52.0-linux-x64.AppImage --no-sandbox 2>/dev/null 1>/dev/null
