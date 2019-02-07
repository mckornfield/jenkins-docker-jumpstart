#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CERT_DIR=${DIR}/certs
REGISTRY_DIR=${DIR}/registry
AUTH_DIR=${DIR}/auth

IMAGE=registry:2

if [ ! -d $CERT_DIR ] || [ -z "$(ls -A $CERT_DIR)" ]; then
  echo "Generating certs"
  $DIR/extract-certs.sh
fi

mkdir -p ${REGISTRY_DIR}

mkdir -p ${AUTH_DIR}

PW=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
echo "Password is $PW"
echo "$PW" > ${AUTH_DIR}/registrypass.txt

docker run \
  --entrypoint htpasswd \
  registry:2 -Bbn admin $PW > auth/htpasswd

docker container stop registry
docker container rm registry

docker run -d \
  -p 4443:443 \
  --restart=always \
  --name registry \
  -v $AUTH_DIR:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/registry.key \
  -v $CERT_DIR:/certs \
  -v ${REGISTRY_DIR}:/var/lib/registry \
  $IMAGE
