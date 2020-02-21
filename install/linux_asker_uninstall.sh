#!/bin/bash
# GNU/Linux ASKER Uninstallation
# version: 20190821
# author: Francisco Vargas Ruiz

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

askerPath=/opt/asker

function exists_binary() {
	which $1 > /dev/null
}

echo "[0/4.INFO] GNU/Linux ASKER uninstallation"

echo "[1/4.INFO] Checking distro..."
[ "$distro" = "" ] && exists_binary zypper && distro=opensuse
[ "$distro" = "" ] && exists_binary apt-get && distro=debian
[ "$distro" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[2/4.INFO] Uninstalling PACKAGES..."
[ $distro = "debian" ] && apt-get remove -y git ruby irb
[ $distro = "opensuse" ] && zypper remove -y git

echo "[3/4.INFO] Uninstalling asker..."
rm -rf /usr/local/bin/asker
rm -rf $askerPath

echo "[4/4.INFO] Finish!"
