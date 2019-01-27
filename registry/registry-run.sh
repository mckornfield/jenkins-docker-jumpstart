#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REGISTRY_DIR=${DIR}/data

IMAGE=registry:2

mkdir -p ${REGISTRY_DIR}

docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:5000 \
  -v ${REGISTRY_DIR}:/var/lib/registry \
  $IMAGE
