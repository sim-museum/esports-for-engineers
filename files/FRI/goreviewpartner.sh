#!/bin/bash

export WINEPREFIX="$PWD/WP"
cd "$WINEPREFIX/../INSTALL/GRP"

wine GoReviewPartner.exe 2>/dev/null 1>/dev/null
# print out credits
cat $WINEPREFIX/../DOC/GoReviewPartnerDoc.txt

