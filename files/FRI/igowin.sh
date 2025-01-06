#!/bin/bash

export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null

cd "$WINEPREFIX/../INSTALL/igowin"

wine igowin.exe 2>/dev/null 1>/dev/null

