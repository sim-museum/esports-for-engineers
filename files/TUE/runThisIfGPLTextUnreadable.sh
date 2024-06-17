#!/bin/bash
# if some of the text on the GPL screens is fuzzy and impossible
# to read, your graphics drivers are probably not optimized.
# at a command prompt, type
# lsmod | grep nouveau
# if this command returns output, you are using a slow, generic
# graphics driver that may be causing the problem
# load proprietary 3rd party drivers appropriate for your graphics
# card.
# if you have an nvidia card, typing
# lsmod | grep nvidia
# at the terminal prompt should produce output
# if not, install the nvidia drivers for your card
# 
# If that didn't work, run this script.  It will 
# probably fix the text at the cost of lower frame rate
# the TUE game will be playable, though.
# Without the right graphics drivers other sim games (such at THU)
# will probably not be playable.
# after runing gplrast, all GPL text should be readable
# This text corruption problem also happens when the 
# Manjaro 20.2 linux distro is used.  Running this
# script will solve the problem in the Manjaro case without
# frame rate penalty.

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi

export WINEPREFIX="$PWD/WP"
cd INSTALL
wine gplrast_v2.5.exe 2>/dev/null 1>/dev/null
exit 0
