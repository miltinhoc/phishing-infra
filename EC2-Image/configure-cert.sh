#!/bin/bash

if [[ -z "$1" ]]; then
    echo "[*] error: no domain provided"
    exit 1
fi

DOMAIN="$1"
KEY="/etc/letsencrypt/live/$DOMAIN/privkey.pem"
CERT="/etc/letsencrypt/live/$DOMAIN/fullchain.pem"

systemctl stop apache2
certbot certonly --standalone -d $DOMAIN -d www.$DOMAIN

# Check for the certificate and private key
if [[ -f "$CERT" && -f "$KEY" ]]; then
    echo "[*] certificate and private key generated with success!"

    echo "[*] changing gophish config..."

    sed -i "s|:80|:443|g" config.json
    sed -i "s|gophish_admin.crt|$CERT|g" config.json
    sed -i "s|gophish_admin.key|$KEY|g" config.json
    sed -i "s|example\.crt|$CERT|g" config.json
    sed -i "s|example\.key|$KEY|g" config.json

    ./gophish
else
    echo "[*] error: couldn't generate certificate and private key."
    exit 1
fi
