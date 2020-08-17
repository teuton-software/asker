#!/bin/bash
# GNU/Linux ASKER Uninstallation
# version: 20200226
# author: Francisco Vargas Ruiz
#         David Vargas Ruiz

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

FOLDER=/opt/asker

function exists_binary() {
	which $1 > /dev/null
}

echo "[0/4.INFO] GNU/Linux ASKER uninstallation"

echo "[1/4.INFO] Checking distro..."
[ "$DISTRO" = "" ] && exists_binary zypper && DISTRO=opensuse
[ "$DISTRO" = "" ] && exists_binary apt-get && DISTRO=debian
[ "$DISTRO" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $DISTRO distribution found"

echo "[2/4.INFO] Uninstalling PACKAGES..."
[ $DISTRO = "debian" ] && apt-get remove -y git ruby irb
[ $DISTRO = "opensuse" ] && zypper remove -y git

echo "[3/4.INFO] Uninstalling asker..."
rm -rf /usr/local/bin/asker
rm -rf $FOLDER

echo "[4/4.INFO] Finish!"
