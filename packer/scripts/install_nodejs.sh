#!/bin/sh
set -e

apt-get update

# Install NodeJS 13.x
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
apt-get install -y nodejs