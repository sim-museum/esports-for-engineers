#!/bin/bash

echo ""
echo "If an installation is not working correctly,"
echo "it can be helpful to delete the installation"
echo "and re-install."
echo "To reinstall, issue these commands:"
echo "sudo mount -o loop <path to Falcon4 CD iso>falcon4Cd.iso myMount"
echo "cd myMount"
echo "wine Setup.exe"
echo "cd .."
echo "export WINEPREFIX=\$PWD\WP"
echo "winetricks dxvk"
echo "winetricks dotnet40"
echo ""
echo "Press Enter to uninstall or <CTRL> C to cancel."
read replyString
rm -rf WP
mkdir WP
