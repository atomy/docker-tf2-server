#!/bin/bash

set -e

echo "Setup script starting..."

# validate
if [ ! -e "build/env" ] ; then
  echo "build/env not found!"
  exit 1
fi

source build/env

DOCKER_BUILD_ARGS=`build/docker/buildDockerEnvArgs.sh`

docker build -t ${ORG_NAME}/${PROJECT_NAME} -f build/docker/tf2/Dockerfile ${DOCKER_BUILD_ARGS} .

echo "ALL DONE"