#!/bin/sh
set -e
while [ "$(curl --insecure -s -o /dev/null -w '%{http_code}' ${HOST_BESU}:4545/liveness)" != "200" ]; do sleep 5; done; echo "success";

envsubst < /opt/lacchain/rotation-validator/config.toml.template > /opt/lacchain/rotation-validator/config.toml
sleep 1;
exec "$@"