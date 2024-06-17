#!/bin/bash
# randomize drivers such that you're racing against different drivers each race
# (assuming you choose 10 or fewer computer opponents)

# if you race against all the computer opponents, of course you'll be 
# racing against the same opponents every time

# the fastest 5 drivers are last in the list, so if you choose 14 or fewer
# computer drivers you will never race against the fastest ones.

export WINEPREFIX=$PWD/WP

cd $WINEPREFIX/drive_c/Sierra/GPL/originalDriverIniFiles

python3 randomizeDrivers.py driv55.ini > ../driv55.ini    
python3 randomizeDrivers.py driv65.ini > ../driv65.ini    
python3 randomizeDrivers.py driv66.ini > ../driv66.ini    
python3 randomizeDrivers.py drivSC.ini > ../drivSC.ini    
python3 randomizeDrivers.py drvc67.ini > ../drvc67.ini    
python3 randomizeDrivers.py drvc69.ini > ../drvc69.ini    
python3 randomizeDrivers.py drvc67.ini > ../drvc67.ini 
python3 randomizeDrivers.py drivF2.ini > ../drivF2.ini 
