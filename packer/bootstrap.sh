#!/bin/bash

sudo yum update -y

# start/enable docker
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker

# build backend image
sudo docker build -t backend /tmp

# enable backend service
sudo mv /tmp/backend.service /etc/systemd/system/backend.service
sudo systemctl enable backend
