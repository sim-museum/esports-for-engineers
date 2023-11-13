
# note: you must manually copy screenshot pngs in ~/Pictures to ./afterGameReport manually.
# copy globulation .game files created in the last 2 hours to afterGameReport
#find $HOME/.glob2 -name "*.game" -type f -mmin -120 -exec cp {} ./afterGameReport \;
# copy all Republic saved games to ./afterGameReport
cp -r "./WP/drive_c/Program Files (x86)/GOG.com/Republic - The Revolution/Main/SaveGame" ./afterGameReport 2>/dev/null 1>/dev/null
