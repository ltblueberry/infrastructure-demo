#!/bin/sh

sudo apt-get update

# Install NodeJS 13.x
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt-get install -y nodejs