#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CERT_DIR=${DIR}/certs

mkdir -p $CERT_DIR

find ${DIR}/.. -name fullchain.pem -type l -exec openssl x509 -in "{}" -outform DER -out $CERT_DIR/registry.crt \;
find ${DIR}/.. -name privkey.pem -type l -exec openssl pkey -in "{}" -out $CERT_DIR/registry.key \;
