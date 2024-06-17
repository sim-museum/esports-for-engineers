#!/bin/bash

export WINEPREFIX="$PWD/WP"
cd "$WINEPREFIX/../INSTALL/igowin"

wine igowin.exe 2>/dev/null 1>/dev/null

