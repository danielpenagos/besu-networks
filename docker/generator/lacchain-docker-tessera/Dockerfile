FROM ubuntu:20.04
ARG VERSION="dev"

RUN apt-get update && \
 apt-get install --no-install-recommends -q --assume-yes  && \
 apt-get clean  && \
 rm -rf /var/lib/apt/lists/*  && \
 adduser --disabled-password --gecos "" --home /opt/besu besu 
WORKDIR /opt
RUN apt-get update && apt-get install -y  software-properties-common unzip wget   
RUN  apt-get install -y git curl gnupg2 && \
  apt-get install -y ca-certificates && \
  apt-get install -y lsb-release && \
  apt-get install -y  make && \
  apt-get install -y gcc && \
  apt-get install -y build-essential  && \
  apt-get install -y libdb-dev && \ 
  apt-get install -y zlib1g-dev && \
  apt-get install -y libtinfo-dev && \ 
  apt-get install -y sysvbanner psmisc  libdb5.3-dev
#   
#

RUN add-apt-repository ppa:openjdk-r/ppa && apt-get install -y openjdk-11-jdk
RUN mkdir -m 0440 ./tmp && \
     wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.17-stable.tar.gz -P /opt/tmp && \
     tar -xvf /opt/tmp/libsodium-1.0.17-stable.tar.gz -C /usr/local
WORKDIR /usr/local/libsodium-stable 
RUN sh ./configure && make && make check && make install


RUN wget https://src.fedoraproject.org/lookaside/pkgs/leveldb/leveldb-1.20.tar.gz/sha512/c59258f2f58ce2d5680e9ab3da4ab0923d91cd4648dcf63cdaa26cdde92bf45e094544539ad11d8e09a4a4813435286143ed0e86c21c6c31a0596903ed4744d2/leveldb-1.20.tar.gz -P /opt/tmp/

RUN tar -xvf /opt/tmp/leveldb-1.20.tar.gz -C /opt/tmp/

WORKDIR /opt/tmp/leveldb-1.20 
RUN make
RUN mv /opt/tmp/leveldb-1.20/out-static/libleveldb.a /usr/local/lib && \
    mv /opt/tmp/leveldb-1.20/out-static/libmemenv.a /usr/local/lib && \
    mv /opt/tmp/leveldb-1.20/out-shared/libleveldb.so.1.20 /usr/local/lib && \
    mv /opt/tmp/leveldb-1.20/out-shared/libleveldb.so /usr/local/lib && \
    mv /opt/tmp/leveldb-1.20/out-shared/libleveldb.so.1 /usr/local/lib && \
    cp -R  /opt/tmp/leveldb-1.20/include/leveldb /usr/local/lib && \
    ldconfig
RUN apt-get install gettext-base
RUN mkdir -m 0440 /usr/local/tessera && \
    wget https://oss.sonatype.org/service/local/repositories/releases/content/net/consensys/quorum/tessera/tessera-app/21.1.1/tessera-app-21.1.1-app.jar -P /opt/tmp && \
    cp /opt/tmp/tessera-app-21.1.1-app.jar  /usr/local/tessera/tessera-app.jar && \
    mkdir -m 0440 /opt/lacchain && \
    mkdir -m 0440 /opt/lacchain/tessera && \
    mkdir -m 0440 /opt/lacchain/tessera/keystor && \
    mkdir -m 0440  /opt/lacchain/tmp && \
    mkdir -m 0440  /opt/lacchain/pwd && \
    echo "default_password" > /opt/lacchain/pwd/.account_pass

COPY --chown=besu:besu ./files/openssl.cnf        /opt/lacchain/tessera/openssl.cnf.template
COPY --chown=besu:besu ./files/tessera.conf       /opt/lacchain/tessera/tessera.conf.template
COPY --chown=besu:besu ./files/start-tessera.sh   /opt/lacchain/start-tessera.sh
COPY --chown=besu:besu ./files/docker-entrypoint.sh /opt/lacchain/entrypoint/docker-entrypoint.sh

WORKDIR /opt/lacchain/tessera/certificates
RUN chmod 0440 /opt/lacchain/tessera/certificates && \
    mkdir -m 0440 /opt/lacchain/tessera/certificates/CAs && \
    mkdir -m 0440  /opt/lacchain/tessera/keystore



RUN echo vm.overcommit_memory = 2 >> /etc/sysctl.conf  && \
    echo vm.overcommit_ratio = 100 >> /etc/sysctl.conf  && \
    sysctl -w vm.max_map_count=131072  && \
    sysctl -p && \
    rm -rf /opt/lacchain/tmp &&  rm  -rf /opt/tmp  && \
    chmod 777 /opt/lacchain/start-tessera.sh

WORKDIR /opt/lacchain/


# Expose services ports
#4040 TCP - Port to communicate with other Tessera nodes.
#4444 TCP - Port for communication between Besu and Tessera.
EXPOSE 4040 4444

ENTRYPOINT [ "/opt/lacchain/entrypoint/docker-entrypoint.sh"]
CMD [ "/opt/lacchain/start-tessera.sh"]



