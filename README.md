# Linux post install automation
Automate your Linux (Debian-like distro is required) post install process.

## Launching the script
[Download](https://raw.githubusercontent.com/ggardin/linux-post-install/master/install.sh) the script and make it executable with:

    chmod +x script-name.sh

Run che script with either one of these commands:

    sudo ./install.sh
    sudo sh install.sh
    sudo bash install.sh

## Content of the script
The `install.sh` bash script installs:

1. [TLP](https://linrunner.de/tlp/index.html) power management, with ThinkPad kernel module (T420 and later generations).
2. Wake On Lan (WOL), via ethtool. If TLP is installed, flag `WOL_DISABLE` in `/etc/tlp.conf` has to be set to `N`. For reference: [Arch Wiki](https://wiki.archlinux.org/index.php/Wake-on-LAN).
3. [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) icon pack.
4. [Arc Theme](https://github.com/jnsh/arc-theme) theme.
5. [Visual Studio Code](https://code.visualstudio.com/) (by Microsoft) and Filezilla.
6. [Remmina](https://remmina.org/) RDP client.
7. Syncthing.
8. Plank dock.

The installation of any of these items is optional.

_Disclaimer: this is a side project for my personal use and comes with no warranties. Anyway, you're welcome to fork, commit and raise issues._

## Reference
1. [Pi-hole](https://github.com/pi-hole/pi-hole/blob/master/automated%20install/basic-install.sh) installation script
2. [Bash Shell Scripting](https://en.wikibooks.org/wiki/Bash_Shell_Scripting) on WikiBooks
3. [Shell scripting adventures](https://saveriomiroddi.github.io/Shell-scripting-adventures-part-3/)

