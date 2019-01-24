#!/bin/bash
# version: 20190124

echo "[INFO] ASKER OpenSUSE installation"
echo "[INFO] Installing PACKAGES..."
apt update
apt install -y git
gem install rake

echo "[INFO] Cloning git REPO..."
git clone https://github.com/dvarrui/asker.git

echo "[INFO] Checking..."
cd asker
rake gems
rake

echo "[INFO] Finish!"
./asker version
