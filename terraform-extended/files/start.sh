#!/bin/sh
set -e

cd ~/app

# Start application
sudo pm2 start app.yml --env staging --log log/application.log
sleep 3

# Save PM2 process
sudo pm2 save