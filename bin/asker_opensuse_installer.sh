#!/bin/bash
# version: 20190124

echo "[INFO] ASKER OpenSUSE installation"
[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

echo "[INFO] Installing OS PACKAGES..."
zypper refresh
zypper install -n git

echo "[INFO] Cloning git REPO..."
cd /opt
git clone https://github.com/dvarrui/asker.git

echo "[INFO] Installing Ruby gems..."
gem install rake
cd asker
rake opensuse
echo "[INFO] Checking..."
rake

echo "[INFO] Finish!"
ruby asker version

echo "[INFO] You can download examples of input files"
echo "       cd PATH/TO/YOUR/HOME/"
echo "       git clone https://github.com/dvarrui/asker-inputs.git"
