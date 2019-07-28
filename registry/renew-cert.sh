#!/bin/bash

sudo docker ps -qa | xargs docker rm -f
sudo docker volume ls | xargs docker volume rm -f
/opt/jenkins-docker-jumpstart/registry/run_callback_nginx.sh $1
/opt/jenkins-docker-jumpstart/registry/retrieve_cert.sh $1

