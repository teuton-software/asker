#!/bin/bash
# version: 20190124

echo "[INFO] ASKER Debian installation"
echo "[INFO] Installing PACKAGES..."
apt update
apt install -y git
apt install -y ruby irb
gem install rake

echo "[INFO] Cloning git REPO..."
git clone https://github.com/dvarrui/asker.git

echo "[INFO] Checking..."
cd asker
rake gems
rake

echo "[INFO] Finish!"
./asker version
