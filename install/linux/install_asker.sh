#!/bin/bash
# GNU/Linux Asker Installation
# version: 20200226
# author: Francisco Vargas Ruiz
#         David Vargas Ruiz

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

FOLDER=/opt/asker
URL=https://github.com/dvarrui/asker.git

function exists_binary() {
	which $1 > /dev/null
}

echo "[0/6.INFO] GNU/Linux ASKER installation"

echo "[1/6.INFO] Checking distro..."
[ "$DISTRO" = "" ] && exists_binary zypper && DISTRO=opensuse
[ "$DISTRO" = "" ] && exists_binary apt-get && DISTRO=debian
[ "$DISTRO" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $DISTRO distribution found"

echo "[2/6.INFO] Installing PACKAGES..."
[ $DISTRO = "debian" ] && apt-get update && apt-get install -y git ruby irb
[ $DISTRO = "opensuse" ] && zypper refresh && zypper install -y git

echo "[3/6.INFO] Rake gem installation"
gem install rake --no-ri

echo "[4/6.INFO] Installing asker..."
git clone $URL $FOLDER -q

echo "[5/6.INFO] Configuring..."
cd $FOLDER
rake install:$DISTRO

echo "[6/6.INFO] Finish!"
