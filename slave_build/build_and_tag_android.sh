#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker build -t jumpstart/android-slave:latest -f  $DIR/Dockerfile_android $DIR
