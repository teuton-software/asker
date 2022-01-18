#!/bin/bash
# GNU/Linux Asker Installation
# author: Francisco Vargas Ruiz
#         David Vargas Ruiz

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

function exists_binary() {
	which $1 > /dev/null
}

echo "[0/6.INFO] GNU/Linux ASKER installation"

echo "[1/4.INFO] Checking distro..."
[ "$DISTRO" = "" ] && exists_binary zypper && DISTRO=opensuse
[ "$DISTRO" = "" ] && exists_binary apt-get && DISTRO=debian
[ "$DISTRO" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $DISTRO distribution found"

echo "[2/4.INFO] Installing PACKAGES..."
[ $DISTRO = "debian" ] && apt update && apt install -y git ruby irb
[ $DISTRO = "opensuse" ] && zypper refresh && zypper install -y git

echo "[3/4.INFO] gem installation"
gem install asker-tool

echo "[4/4.INFO] Finish!"
