#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CERT_DIR=${DIR}/certs
REGISTRY_DIR=${DIR}/registry

IMAGE=registry:2

if [ ! -d $CERT_DIR ] || [ -z "$(ls -A $CERT_DIR)" ]; then
  echo "Generating certs"
  $DIR/extract-certs.sh
fi

mkdir -p ${REGISTRY_DIR}

docker run -d \
  -p 443:443 \
  --restart=always \
  --name registry \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=${CERT_DIR}/registry.crt \
  -e REGISTRY_HTTP_TLS_KEY=${CERT_DIR}/registry.key \
  -v $CERT_DIR:/certs \
  -v ${REGISTRY_DIR}:/var/lib/registry \
  $IMAGE
