#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

IMAGE=jumpstart/jenkins:latest

docker build --no-cache $DIR -t $IMAGE
docker system prune -f 

JENKINS_HOME=$DIR/jenkins_home
JENKINS_SECRETS=$DIR/secrets
JENKINS_SSH=$DIR/ssh

if [ ! -d $JENKINS_HOME ]; then
  echo "Creating jenkins_home directory in current folder"
  mkdir $JENKINS_HOME
fi
if [ ! -d $JENKINS_SSH ]; then
  echo "Creating jenkins_home directory in current folder"
  mkdir $JENKINS_SSH
fi

if [ ! -d $JENKINS_SECRETS ]; then
  mkdir $JENKINS_SECRETS
  if [[ -z $1 ]]; then
    echo "Creating secrets directory in current folder with default password 'a'"
    echo "a" >> $JENKINS_SECRETS/jenkins_admin_password
  else
    echo "Using passed in password"
    echo $1 >> $JENKINS_SECRETS/jenkins_admin_password
  fi
fi

chown -R 1000:1000 $JENKINS_HOME
chown -R 1000:1000 $JENKINS_SECRETS
chown -R 1000:1000 $JENKINS_SSH

$DIR/run.sh
