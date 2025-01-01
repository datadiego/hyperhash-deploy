#!/bin/bash

# Antes de lanzar este script:
#
# 1. Asegúrate de asignar un dominio a la IP de tu servidor
# 2. Asegúrate de que los DNS se hayan propagado correctamente y apunten a tu servidor

# Variables
DOMAIN=you.com
EMAIL=you@gmail.com

sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw reload

docker run -it --rm \
  -v $(pwd)/certs:/etc/letsencrypt \
  -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf \
  certbot/certbot certonly --nginx --non-interactive --agree-tos --email $EMAIL -d $DOMAIN

docker-compose up -d