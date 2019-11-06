#!/bin/sh

# Create instance with startup script
gcloud compute instances create dummy-app\
  --boot-disk-size=10GB \
  --image-project=ubuntu-os-cloud \
  --image-family=ubuntu-1604-lts \
  --machine-type=g1-small \
  --zone=europe-west4-b \
  --tags dummy-server \
  --restart-on-failure \
  --metadata-from-file startup-script=startup.sh