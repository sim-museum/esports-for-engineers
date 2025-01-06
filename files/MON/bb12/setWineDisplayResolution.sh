#!/bin/bash
export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  # 2>/dev/null 1>/dev/null
winecfg 2>/dev/null 1>/dev/null
exit 0
