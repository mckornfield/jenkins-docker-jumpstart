#!/bin/bash

sudo docker run -it --rm \
-v $PWD/cert-volumes/etc/letsencrypt:/etc/letsencrypt \
-v $PWD/cert-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
-v $PWD/letsencrypt-site:/data/letsencrypt \
-v $PWD/cert-volumes/var/log/letsencrypt:/var/log/letsencrypt \
certbot/certbot \
certonly --webroot \
--register-unsafely-without-email --agree-tos \
--webroot-path=/data/letsencrypt \
-d $1
