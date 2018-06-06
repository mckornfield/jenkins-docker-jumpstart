#!/bin/bash

rm cert-nginx.conf
cp cert-nginx.conf.template cert-nginx.conf
sed -i "s/REPLACE_ME/$1/g" cert-nginx.conf
docker stop cert-callback
docker rm cert-callback
docker run -p "80:80" \
-v $PWD/cert-nginx.conf:/etc/nginx/conf.d/default.conf \
-v $PWD/letsencrypt-site:/usr/share/nginx/html \
--name cert-callback \
-d nginx:latest

