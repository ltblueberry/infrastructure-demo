#!/bin/sh

gcloud compute instances create dummy-app\
  --boot-disk-size=10GB \
  --image-family=nodejs-full \
  --machine-type=g1-small \
  --zone=europe-west4-b \
  --tags dummy-server \
  --restart-on-failure