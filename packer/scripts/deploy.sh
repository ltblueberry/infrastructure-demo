#!/bin/sh
set -e

apt-get update
apt-get install -y zip unzip

# Download dummy project
wget -P ~/ https://github.com/ltblueberry/dummy-node-mongo/archive/master.zip
unzip ~/master.zip -d ~/; sudo mv ~/dummy-node-mongo-master ~/app

# Instal PM2 nodejs process manager
npm install pm2 -g
pm2 startup
systemctl enable pm2-root

# Install project dependencies
cd ~/app
npm install

# Start application
pm2 start bin/www --name "dummy" --log log/application.log
sleep 3

# Save PM2 process
pm2 save