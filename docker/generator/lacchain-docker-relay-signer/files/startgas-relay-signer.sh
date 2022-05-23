#!/bin/sh
set -e
while [ "$(curl --insecure -s -o /dev/null -w '%{http_code}' ${HOST_BESU}:4545/liveness)" != "200" ]; do sleep 5; done; echo "success";
export WRITER_KEY=`cat /opt/secret/key`
echo $WRITER_KEY
envsubst < /opt/lacchain/gas-relay-signer/config.toml.template > /opt/lacchain/gas-relay-signer/config.toml
sleep 1;
exec "$@"