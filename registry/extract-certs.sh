#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CERT_DIR=${DIR}/certs
CRT_FILE=${CERT_DIR}/registry.crt
KEY_FILE=${CERT_DIR}/registry.key

mkdir -p $CERT_DIR

find ${DIR}/.. -name fullchain.pem -type l -exec cat {} > $CRT_FILE \;
find ${DIR}/.. -name privkey.pem -type l -exec cat {} >> $CRT_FILE \;
find ${DIR}/.. -name privkey.pem -type l -exec cat {} > $KEY_FILE \;

chmod 777 $CRT_FILE
chmod 777 $KEY_FILE
