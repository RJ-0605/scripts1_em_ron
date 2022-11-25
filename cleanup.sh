#! /bin/sh

cd ~/workspace
docker compose down
docker container rm -f $(docker container ls -q)
docker image rm -f $(docker image ls -q)
sudo rm -rf *.*
sudo rm -rf *
cd ~/
sudo rm -rf ~/workspace
mkdir ~/workspace