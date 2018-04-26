#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker build -t jumpstart/nodejs-slave:latest -f  $DIR/Dockerfile_nodejs $DIR
