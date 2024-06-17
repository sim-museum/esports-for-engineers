# install wine 7 on Ubuntu 22.04LTS using saved .deb files
if [ ! -f /opt/wine-staging/bin/winetricks ]
then
        clear
	printf "Installing wine-7.7 (Staging).   This will take a few minutes.\n\nNote: when running this version of wine, you will be prompted\n\nasking whether to install Mono.  Do not install Mono.\n\n\nPress a key to continue.\n\n\n"

	
	sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/libvkd3d-shader1_1.3~jammy-1_amd64.deb 2>/dev/null 1>/dev/null

sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/libvkd3d-shader1_1.3~jammy-1_i386.deb  2>/dev/null 1>/dev/null


sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/libvkd3d1_1.3~jammy-1_amd64.deb  2>/dev/null 1>/dev/null

sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/libvkd3d1_1.3~jammy-1_i386.deb  2>/dev/null 1>/dev/null


sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/libvkd3d-utils1_1.3~jammy-1_amd64.deb  2>/dev/null 1>/dev/null

sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/libvkd3d-utils1_1.3~jammy-1_i386.deb  2>/dev/null 1>/dev/null


#sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/libvkd3d-headers_1.3~jammy-1_all.deb

#sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/libvkd3d-dev_1.3~jammy-1_amd64.deb

sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/vkd3d-compiler_1.3~jammy-1_amd64.deb  2>/dev/null 1>/dev/null

sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/vkd3d-compiler_1.3~jammy-1_i386.deb  2>/dev/null 1>/dev/null


sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/wine-staging-i386_7.7~jammy-1_i386.deb  2>/dev/null 1>/dev/null

sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/wine-staging_7.7~jammy-1_i386.deb  2>/dev/null 1>/dev/null

sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/wine-staging-amd64_7.7~jammy-1_amd64.deb  2>/dev/null 1>/dev/null

sudo apt install -y ./wine_7_7_staging_for_Ubuntu_22.04LTS/wine-staging_7.7~jammy-1_amd64.deb  2>/dev/null 1>/dev/null

fi

sudo apt remove -y wine-development 2>/dev/null 1>/dev/null

sudo ./wine_7_7_staging_for_Ubuntu_22.04LTS/makeSymbolicLinks.sh 2>/dev/null 1>/dev/null

sudo cp ./wine_7_7_staging_for_Ubuntu_22.04LTS/winetricks /opt/wine-staging/bin 
# need absolute path for ln -s
sudo ln -s /opt/wine-staging/bin/winetricks /bin/winetricks 2>/dev/null 1>/dev/null
