#!/bin/bash
# version: 20190126

echo "[INFO] ASKER Debian installation"
[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

echo "[INFO] Installing OS PACKAGES..."
apt update
apt install -y git
apt install -y ruby

echo "[INFO] Cloning git REPO..."
git clone https://github.com/dvarrui/asker.git

echo "[INFO] Installing Ruby gems..."
gem install rake
cd asker
rake debian
echo "[INFO] Checking..."
rake

echo "[INFO] Finish!"
ruby asker version
