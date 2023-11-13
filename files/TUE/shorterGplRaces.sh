#!/bin/bash
# for the '67 Grand Prix tracks, which are:
#
# Silverstone Circuit
# Monaco
# Zandvoort
# Monza
# Rouen-les-Essarts
# Mexico
# Spa Francorchamps
# Kyalami
# Mosport Park
# Nürburgring
#
# Shorten the Pro Short race to 3 laps, and reduce opponent speed by 30%
# this makes the races shorter and easier to win
# this works only for with the 55 mod and the 67 mod cars

export WINEPREFIX=$PWD/WP

if [ ! -f "$WINEPREFIX/drive_c/Sierra/GPL/tracks/zandvort/track67.ini" ]
then
	clear
	printf "\n\nshorterRaceFiles.sh: 1967 tracks not installed.  Reinstall gpl using the Grand Prix Legends CD\nto install the default 1967 tracks\n\n"
	exit 0
fi

# backup season files
cp "$WINEPREFIX/drive_c/Sierra/GPL/seasons/67season.ini" "$WINEPREFIX/drive_c/Sierra/GPL/shortRaceFiles/backup"
cp "$WINEPREFIX/drive_c/Sierra/GPL/seasons/55season.ini" "$WINEPREFIX/drive_c/Sierra/GPL/shortRaceFiles/backup"

# copy season files with reduced laps for '67 grand prix tracks
cp "$WINEPREFIX/drive_c/Sierra/GPL/shortRaceFiles/new/67season.ini" "$WINEPREFIX/drive_c/Sierra/GPL/seasons"
cp "$WINEPREFIX/drive_c/Sierra/GPL/shortRaceFiles/new/55season.ini" "$WINEPREFIX/drive_c/Sierra/GPL/seasons"

# copy track files with cars 20% slower

rsync -a "$WINEPREFIX/drive_c/Sierra/GPL/shortRaceFiles/new/tracks/" "$WINEPREFIX/drive_c/Sierra/GPL/tracks/"

