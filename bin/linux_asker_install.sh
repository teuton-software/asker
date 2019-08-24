#!/bin/bash
# GNU/Linux Asker Installation
# version: 20190821
# author: Francisco Vargas Ruiz

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

askerPath=/opt/asker
askerUrl=https://github.com/dvarrui/asker.git

function exists_binary() {
	which $1 > /dev/null
}

echo "[0/6.INFO] GNU/Linux ASKER installation"

echo "[1/6.INFO] Checking distro..."
[ "$distro" = "" ] && exists_binary zypper && distro=opensuse
[ "$distro" = "" ] && exists_binary apt-get && distro=debian
[ "$distro" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[2/6.INFO] Installing PACKAGES..."
[ $distro = "debian" ] && apt-get update && apt-get install -y git ruby irb
[ $distro = "opensuse" ] && zypper refresh && zypper install -y git

echo "[3/6.INFO] Rake gem installation"
gem install rake --no-ri

echo "[4/6.INFO] Installing asker..."
git clone $askerUrl $askerPath -q

echo "[5/6.INFO] Configuring..."
cd $askerPath
rake $distro

echo "[6/6.INFO] Finish!"
