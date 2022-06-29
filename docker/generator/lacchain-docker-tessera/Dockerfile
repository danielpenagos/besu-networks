FROM  quorumengineering/tessera:21.1.1
WORKDIR /opt
#https://github.com/ConsenSys/tessera
RUN apk upgrade --update-cache --available && \ 
    apk add --no-cache ca-certificates && \
    apk add gettext libintl && apk add curl && \
    apk add openssl && \
    rm -rf /var/cache/apk/*
RUN mkdir -m 0440 /usr/local/tessera && \
    mkdir -m 0440 /opt/lacchain && \
    mkdir -m 0440 /opt/lacchain/tessera && \
    mkdir -m 0440 /opt/lacchain/tessera/keystor && \
    mkdir -m 0440  /opt/lacchain/tmp && \
    mkdir -m 0440  /opt/lacchain/pwd && \
    echo "default_password" > /opt/lacchain/pwd/.account_pass

COPY  ./files/openssl.cnf        /opt/lacchain/tessera/openssl.cnf.template
COPY  ./files/tessera.conf       /opt/lacchain/tessera/tessera.conf.template
COPY  ./files/start-tessera.sh   /opt/lacchain/start-tessera.sh
COPY  ./files/docker-entrypoint.sh /opt/lacchain/entrypoint/docker-entrypoint.sh

WORKDIR /opt/lacchain/tessera/certificates
RUN chmod 0440 /opt/lacchain/tessera/certificates && \
    mkdir -m 0440 /opt/lacchain/tessera/certificates/CAs && \
    mkdir -m 0440  /opt/lacchain/tessera/keystore && \
    chmod 777 /opt/lacchain/start-tessera.sh
WORKDIR /opt/lacchain/

# Expose services ports
#4040 TCP - Port to communicate with other Tessera nodes.
#4444 TCP - Port for communication between Besu and Tessera.
EXPOSE 4040 4444

ENTRYPOINT [ "/opt/lacchain/entrypoint/docker-entrypoint.sh"]
CMD [ "/opt/lacchain/start-tessera.sh"]