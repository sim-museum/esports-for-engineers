#!/usr/bin/bash
clear
echo "See optionalLinuxNativeInstall.txt for configuration instructions."
export WINEPREFIX=$PWD/WP
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null

./INSTALL/BanksiaGui/BanksiaGui.sh 2>/dev/null 1>/dev/null

