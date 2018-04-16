#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

IMAGE=jumpstart/jenkins:latest

JENKINS_HOME=$DIR/jenkins_home
JENKINS_SECRETS=$DIR/secrets
SSH_DIR=$DIR/ssh

docker run -p 8080:8080 -p 50000:50000 \
  -v $JENKINS_HOME:/Users/jenkins_home \
  -v $JENKINS_SECRETS:/secrets \
  -v $SSH_DIR:/usr/share/jenkins/ref/.ssh \
  --name jenkins -d \
  $IMAGE
