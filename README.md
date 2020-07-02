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
The `install.sh` bash script adds:

1. [TLP](https://linrunner.de/tlp/index.html) power management, with ThinkPad kernel module (T420 and later generations).
1. Wake On Lan (WOL), via ethtool.
1. [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) icon pack.
1. [Arc Theme](https://github.com/jnsh/arc-theme) theme.
1. [Visual Studio Code](https://code.visualstudio.com/) (by Microsoft) and Filezilla.
1. Plank dock.

The installation of any of these items is optional.

_Disclaimer: this is a side project for my personal use and comes with no warranties. Anyway, you're welcome to fork, commit and raise issues._
