#!/bin/bash

docker build -t gophish_image .
docker run -d -p 3333:3333 -p 80:80 -p 443:443 --restart=always --name gophish_container gophish_image
