#!/bin/bash

CONTAINER=$(docker ps --format "{{.ID}}" | head -n 1)

if [[ -z "$CONTAINER" ]]; then
	echo "[*] no containers found."
	exit 1
fi

docker exec -it $CONTAINER /bin/bash