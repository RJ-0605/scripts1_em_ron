#! /bin/sh
ecr_repo="644435390668.dkr.ecr.us-west-2.amazonaws.com"

cd ~/workspace
tar -xzvf *.targz
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin $ecr_repo
docker compose up --build -d