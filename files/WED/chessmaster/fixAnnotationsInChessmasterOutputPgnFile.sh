#!/bin/bash

# by default, Chessmaster annotations in pgn files use
# unreadable hex character codes in place of K, Q, B etc.
# this simple script translates hex characters into 
# standard pgn notation.

if [ $# -ne 2 ]; then
	echo "Usage: $0 inputPgnFname outputPgnFname" 1>&2
	exit 1
fi

export WINEPREFIX=$PWD/WP

rsync -a "$WINEPREFIX/drive_c/Program Files (x86)/Ubisoft/Chessmaster Grandmaster Edition/Data/Users/" $WINEPREFIX/../savedGames/ 2>/dev/null 1>/dev/null

# replace hex characters with text chess symbols

sed 's/\x8b/K/g' $1 | sed 's/\x89/Q/g' | sed 's/\x86/B/g' | sed 's/\x87/N/g' | sed 's/\x88/R/g' > tmp.txt

tr -cd '[:print:]' < tmp.txt > $2

clear
echo -e "Chessmaster saved games copied to $WINEPREFIX/../chessmasterSavedGames.\n\n$1 converted to standard pgn format.  Now to add stockfish annotations:\n1. run ./scid.sh,\n2. read in $2\n3. add scid (stockfish) annotations\n4. Edit/Copy Game to Clipboard\n5. paste into a new pgn file.\n\n"

