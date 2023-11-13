#!/bin/bash
# this restores default race length and opponent
# speed, reversing the effect of
# shorterGplRaces.sh

export WINEPREFIX=$PWD/WP

if [ ! -f "$WINEPREFIX/drive_c/Sierra/GPL/shortRaceFiles/new/67season.ini" ]
then
	# shorterGplRaces not run, therefore nothing to undo
	printf "\nGPL races are already the default length\n\n"
	exit 0
fi

# restore backup season files
cp "$WINEPREFIX/drive_c/Sierra/GPL/shortRaceFiles/backup/67season.ini" "$WINEPREFIX/drive_c/Sierra/GPL/seasons/" 
cp "$WINEPREFIX/drive_c/Sierra/GPL/shortRaceFiles/backup/55season.ini" "$WINEPREFIX/drive_c/Sierra/GPL/seasons/"

# restore original track.ini files

rsync -a "$WINEPREFIX/drive_c/Sierra/GPL/shortRaceFiles/backup/tracks/" "$WINEPREFIX/drive_c/Sierra/GPL/tracks/"

