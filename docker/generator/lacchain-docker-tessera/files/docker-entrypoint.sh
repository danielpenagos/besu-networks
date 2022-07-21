#!/bin/sh
# vim:sw=4:ts=4:et

set -e

envsubst '$DNS_NAME $PUBLIC_IP' < /opt/lacchain/tessera/openssl.cnf.template >/opt/lacchain/tessera/openssl.cnf 
envsubst '$DNS_NAME $PUBLIC_IP $HOST_TESSERA_PEER' < /opt/lacchain/tessera/tessera.conf.template >/opt/lacchain/tessera/tessera.conf
cd /opt/lacchain/tessera/certificates
openssl genrsa -out tessera_ca.key 2048 && \
    openssl req -x509 -new -nodes -key /opt/lacchain/tessera/certificates/tessera_ca.key -sha256 -days 1024 -out tessera_ca.pem -subj "/C=US/ST=Washington/L=Seatle/O=Lacchain/OU=Network/CN=Lacchain CA" && \
    openssl genrsa -out /opt/lacchain/tessera/certificates/tessera_cer.key 2048 && \
    echo "fase 1" && \
    openssl req -new -key /opt/lacchain/tessera/certificates/tessera_cer.key -out tessera_cer.csr -subj "/C=US/ST=Washington/L=Seatle/O=Lacchain/OU=Network/CN=${DNS_NAME}" -config /opt/lacchain/tessera/openssl.cnf && \
    openssl x509 -req -in /opt/lacchain/tessera/certificates/tessera_cer.csr -CA /opt/lacchain/tessera/certificates/tessera_ca.pem -CAkey /opt/lacchain/tessera/certificates/tessera_ca.key -CAcreateserial -out tessera_cer.pem -days 500 -sha256 -extfile /opt/lacchain/tessera/openssl.cnf -extensions v3_req && \
    echo "fase 2"
cd /opt/lacchain/tessera/keystore

#cat /opt/lacchain/pwd/.account_pass | java -jar /usr/local/tessera/tessera-app.jar -keygen -filename nodeKey 


FILE=/opt/lacchain/tessera/keystore/nodeKey.pub 
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "$FILE does not exist."
    cat /opt/lacchain/pwd/.account_pass | java -jar /tessera/tessera-app.jar -keygen -filename nodeKey 
   # cp /opt/lacchain/tessera/keystore/nodeKey.pub /data/tessera/keystore/nodeKey.pub
fi


#while [ "$(curl --insecure -s -o /dev/null -w '%{http_code}' ${HOST_BESU}:4545/liveness)" != "200" ]; do sleep 5; done; echo "success";
 echo "finsh entrypoint"
sleep 2;
exec "$@"
