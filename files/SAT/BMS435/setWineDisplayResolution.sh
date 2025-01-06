#!/bin/bash

export WINEPREFIX="$PWD/WP"
winecfg 2>/dev/null 1>/dev/null
exit 0
