#!/bin/sh

# Create Firewall rule to allow all incoming traffic on TCP port 3000 for "dummy-server" taged instances

gcloud compute firewall-rules create "default-dummy-server" --allow tcp:3000 \
    --source-ranges "0.0.0.0/0" \
    --description "Allow incoming traffic on TCP port 3000" \
    --direction INGRESS \
    --target-tags "dummy-server"