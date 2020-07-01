#!/bin/bash

# Goal: Script which automatically sets up a new Debian-based machine after installation

# Test to see if user is running with root privileges.
if [[ "${UID}" -ne 0 ]]
then
 echo 'Must execute with sudo or root' >&2
 exit 1
fi

# Ensure system is up to date and upgrade
sudo apt-get update
sudo apt-get upgrade -y

# WOL optional install 
echo "
######################################################################################################
Do you want to enable Wake On Lan (WOL)? [y]/n
######################################################################################################
"
read $wol

if [[ $wol -eq "y" ]] || [[ $wol -eq "yes" ]] || [[ $wol -eq "" ]]; then
    sudo apt-get install ethtool
    echo "List of network adapters found on the system:"
    ip a
    echo "Please type the LAN adapter interface name:"
    read $interface
    sudo ethtool -s $interface wol g
    echo "WOL was succesfully enabled."
    echo "However, now you need to enable a startup script. Google for it!"
else 
    echo "WOL was not installed"
fi

# Iconpack customization
echo "
######################################################################################################
Do you want to install Papirus iconpack? [y]/n
######################################################################################################
"
read $papirus

if [[ $papirus -eq "y" ]] || [[ $papirus -eq "yes" ]] || [[ $papirus -eq "" ]]; then
    sudo add-apt-repository ppa:papirus/papirus
    sudo apt-get update
    sudo apt-get install papirus-icon-theme
else 
    echo "Papirus iconpack was not installed"
fi

# Theme customization
echo "
######################################################################################################
Do you want to install Arc theme? [y]/n
######################################################################################################
"
read $arctheme

if [[ $arctheme -eq "y" ]] || [[ $arctheme -eq "yes" ]] || [[ $arctheme -eq "" ]]; then
    sudo apt-get install arc-theme
else 
    echo "Arc theme was not installed"
fi

# Web Dev utilities
echo "
######################################################################################################
Do you want to install web dev utilities? [y]/n
VS Code, Filezilla
######################################################################################################
"
read $web

if [[ $web -eq "y" ]] || [[ $web -eq "yes" ]] || [[ $web -eq "" ]]; then
    sudo apt-get install filezilla
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt-get install apt-transport-https
    sudo apt-get update
    sudo apt-get install code
    
else 
    echo "Web dev utilities were not installed"
fi

# Install Plank dock
sudo apt-get install plank

# Cleanup
sudo apt autoremove
sudo apt clean 

exit 0
