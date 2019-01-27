#!/bin/bash
# version: 20190124

echo "[INFO] ASKER OpenSUSE installation"
[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

echo "[INFO] Installing OS PACKAGES..."
apt update
apt install -y git

echo "[INFO] Cloning git REPO..."
git clone https://github.com/dvarrui/asker.git

echo "[INFO] Installing Ruby gems..."
gem install rake
cd asker
rake opensuse
echo "[INFO] Checking..."
rake

echo "[INFO] Finish!"
ruby asker version
