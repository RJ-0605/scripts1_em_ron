#! /bin/sh -e

version="$1"
archiveName="lavagna-startup-package"
ecr_repo="644435390668.dkr.ecr.us-west-2.amazonaws.com"
ecr_tag="agadzi_lavagna"


function cleanup() {
  rm -rf ${archiveName}*
}

function effectVersion() {
  # change version in docker-compose.yaml
  sed -i '' "s/image: .*${ecr_tag}.*/image: ${ecr_repo}\/${ecr_tag}:${version}/g" docker-compose.yaml
}

function buildArchives() {
  tar -czvf "${archiveName}_${version}.targz" .
  echo "Built ${archiveName}_${version}.targz"
}

function pushImage() {
  aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin $ecr_repo
  docker build -t "${ecr_tag}:${version}" .
  docker tag "${ecr_tag}:${version}" "${ecr_repo}/${ecr_tag}:${version}"
  docker push "${ecr_repo}/${ecr_tag}:${version}"
}

if [[ -z "$version" ]]; then
  echo "Pass a version name to the command; eg. ./build_script.sh 1.0"
  exit 1
fi

cleanup
effectVersion
buildArchives
pushImage