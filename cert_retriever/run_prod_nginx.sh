#!/bin/bash

docker stop prod-nginx
docker rm prod-nginx
if [ -z $PWD/dh-param/dhparam-2048.pem ]; then
  mkdir -p $PWD/dh-param/
  sudo openssl dhparam -out $PWD/dh-param/dhparam-2048.pem 2048
fi

docker run -p "80:80" \
-p "443:443" \
-v $PWD/production.conf:/etc/nginx/conf.d/default.conf \
-v $PWD/lets-encrypt-site:/usr/share/nginx/html \
-v $PWD/dh-param/dhparam-2048.pem:/etc/ssl/certs/dhparam-2048.pem \
-v $PWD/cert-volumes/etc/letsencrypt/live/$1/fullchain.pem:/etc/letsencrypt/live/ci.treetracker.org/fullchain.pem \
-v $PWD/cert-volumes/etc/letsencrypt/live/$1/privkey.pem:/etc/letsencrypt/live/ci.treetracker.org/privkey.pem \
--name prod-nginx \
-d nginx:latest nginx-debug -g 'daemon off;'
