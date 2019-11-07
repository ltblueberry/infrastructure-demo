#!/bin/sh
set -e

sudo apt-get install -y unzip

# Download dummy project
wget -P ~/ https://github.com/ltblueberry/dummy-node-mongo/archive/master.zip
unzip ~/master.zip -d ~/; sudo mv ~/dummy-node-mongo-master ~/app

# Instal PM2 nodejs process manager
sudo npm install pm2 -g
sudo pm2 startup
sudo systemctl enable pm2-root

# Install project dependencies
cd ~/app
npm install

