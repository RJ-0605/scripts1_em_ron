#! /bin/sh

ec2="54.187.158.180"
key="-i ../../agadzi-keypair-develeap.cer"
user="ubuntu"
ecr_repo="644435390668.dkr.ecr.us-west-2.amazonaws.com"

function copyFiles() {
  echo "cleaning up system"
  ssh -t ${user}@${ec2} < ./cleanup.sh
  echo "copying files to system"
  scp $key *.targz ${user}@${ec2}:/home/ubuntu/workspace/files.targz
  scp $key ./startup.sh ${user}@${ec2}:/home/ubuntu/workspace/startup.sh
}

function startUp() {
  ssh -t ${user}@${ec2} "~/workspace/startup.sh"
}

copyFiles
startUp