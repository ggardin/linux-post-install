#!/bin/bash

# Goal: Script which automatically sets up a new Debian-based machine after installation

# Test to see if user is running with root privileges.
if [[ "${UID}" -ne 0 ]]
then
 echo 'Must execute with sudo or root' >&2
 exit 1
fi

# Ensure system is up to date and upgrade
echo "Updating and upgrading packages..."
sudo apt-get update
sudo apt-get upgrade -y

# Laptop check for TLP 
echo "
######################################################################################################
Is this a ThinkPad laptop? [y]/n
######################################################################################################
"
read $laptop

if [[ $laptop -eq "y" ]] || [[ $laptop -eq "yes" ]]; then
    echo "Installing TLP and ACPI module from PPA..."
    sudo add-apt-repository ppa:linrunner/tlp
    sudo apt update
    sudo apt install tlp tlp-rdw
    sudo apt install acpi-call-dkms
    echo "Starting TLP..."
    sudo tlp start
else 
    echo "Skipping TLP power management installation."
fi

# WOL optional install 
echo "
######################################################################################################
Do you want to enable Wake On Lan (WOL)? [y]/n
######################################################################################################
"
read $wol

if [[ $wol -eq "y" ]] || [[ $wol -eq "yes" ]]; then
    echo "Installing ethtool..."
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

if [[ $papirus -eq "y" ]] || [[ $papirus -eq "yes" ]]; then
    echo "Installing Papirus from PPA..."
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

if [[ $arctheme -eq "y" ]] || [[ $arctheme -eq "yes" ]]; then
    echo "Installing Arc theme..."
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

if [[ $web -eq "y" ]] || [[ $web -eq "yes" ]]; then
    echo "Installing Filezilla..."
    sudo apt-get install filezilla
    echo "Installing Visual Studio Code..."
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt-get install apt-transport-https
    sudo apt-get update
    sudo apt-get install code
    
else 
    echo "Web dev utilities were not installed"
fi

# Install Remmina RDP client
echo "Installing Remmina..."
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt update
sudo apt install remmina remmina-plugin-rdp remmina-plugin-secret

# Install Syncthing
echo "Installing Syncthing..."
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
sudo apt-get update
sudo apt-get install syncthing

# Install Plank dock
echo "Installing Plank..."
sudo apt-get install plank

# Install Kmix for proper media keys support in KDE
sudo apt-get install kmix

# Cleanup
echo "Cleaning up..."
sudo apt autoremove
sudo apt clean 

exit 0
