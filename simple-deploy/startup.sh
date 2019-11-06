#!/bin/sh

# Startup script, contains of all commands from 3 base scripts
# Used in create-vm.sh as a metadata-from-file startup-script

sudo apt-get update

# Install NodeJS 13.x
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install MongoDB latest
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# Start mongod service
sudo systemctl start mongod

# Add mongod service to autostart
sudo systemctl enable mongod

sudo apt-get update
sudo apt-get install -y zip unzip

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

# Start application
sudo pm2 start bin/www --name "dummy" --log log/application.log
sleep 3

# Save PM2 process
sudo pm2 save