#!/bin/bash
mkdir tessera1
mkdir tessera2
mkdir tessera3
chmod -R 755  tessera1
chmod -R 755  tessera2
chmod -R 755  tessera3

docker-compose  up -d besu1
sleep 2;
export IP_BOOT_NODE=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'  writer-besu-local-01`
echo $IP_BOOT_NODE
docker-compose  up -d 