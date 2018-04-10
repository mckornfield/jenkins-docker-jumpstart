#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

IMAGE=jumpstart/jenkins:latest

docker build --no-cache $DIR -t $IMAGE
 
JENKINS_HOME=$DIR/jenkins_home
JENKINS_SECRETS=$DIR/secrets

if [ ! -d $JENKINS_HOME ]; then
  echo "Creating jenkins_home directory in current folder"
  mkdir $JENKINS_HOME
fi

if [ ! -d $JENKINS_SECRETS ]; then
  echo "Creating secrets directory in current folder with default password 'a'"
  mkdir $JENKINS_SECRETS
  echo "a" >> $JENKINS_SECRETS/jenkins_admin_password # REPLACE THE FOLLOWING TO MAKE MORE SECURE
fi

$DIR/run.sh
