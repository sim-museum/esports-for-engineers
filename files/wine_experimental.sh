#!/bin/bash

# if not using the recommended distro (Ubuntu 22.04 LTS) then need to 
# add the winehq repository
# this is not ideal, because the experimental version is regularly
# updated, thus you'll be using a new version that has not been
# tested with esports-for-engineers
# it will probably work, however

# Script Outline:
# 1. Check if the system is running Ubuntu 22.04.
# 2. If not running Ubuntu 22.04, provide instructions for adding the winehq-staging repository.
# 3. If running Ubuntu 22.04, proceed to install Wine using a custom script.

#!/bin/bash

# This script checks if the system is running Ubuntu 22.04.
# If not, it provides instructions for adding the winehq-staging repository.
# If the system is running Ubuntu 22.04, it proceeds to install Wine using a custom script.

# Check if the system is running Ubuntu 22.04
if ! grep -q "Ubuntu 22.04" /etc/issue; then
    # If not running Ubuntu 22.04, provide instructions for adding winehq-staging repository
    echo "If you have already added the winehq-staging repository, copy and paste the following line:"
    echo "sudo apt install --install-recommends winehq-staging"; echo " "
    echo "If you haven't, first add the repository"
    echo "# by copy/pasting the following commands one by one into a terminal window"
    echo "(reference: https://wiki.winehq.org/Ubuntu)"; echo " "
    echo "sudo dpkg --add-architecture i386"
    echo "wget -nc https://dl.winehq.org/wine-builds/winehq.key"
    echo "sudo apt-key add winehq.key"
    echo "sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ jammy main'"
    echo "sudo apt update"
    echo "sudo apt install --install-recommends winehq-staging";
    echo "sudo winetricks --self-update"
    echo " "
    echo "Choose to install gecko (the wine help HTML reader) if prompted to do so when installing a game."
    exit 0
fi

# If running Ubuntu 22.04, proceed to install Wine using a custom script
./wine7_2204LTS.sh
exit 0

