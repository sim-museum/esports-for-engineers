#!/bin/bash

export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null

cd "$WINEPREFIX/../INSTALL/GRP"

wine GoReviewPartner.exe 2>/dev/null 1>/dev/null
# print out credits
cat $WINEPREFIX/../DOC/GoReviewPartnerDoc.txt

