#!/bin/bash
export WINEPREFIX="$PWD/WP"
wine winecfg -v win7  2>/dev/null 1>/dev/null

winecfg 2>/dev/null 1>/dev/null
exit 0
