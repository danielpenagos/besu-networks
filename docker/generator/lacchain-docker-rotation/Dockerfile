###MULTI SSTAGE BUILDS
### STAGE 1: Build ###
#FROM golang:1.11-alpine AS builder
FROM golang:1.18.1-alpine3.15 AS builder
RUN apk add --update git && apk add build-base  make gcc musl-dev linux-headers
RUN mkdir lacchain
WORKDIR /lacchain

RUN git clone https://github.com/LACNetNetworks/rotation-validator.git
WORKDIR /lacchain/rotation-validator/client
RUN go mod download
RUN export GO111MODULE=on &&  go build  -o /go/bin/client *.go

# ### STAGE 2: Setup ###
FROM alpine:latest
RUN apk add --no-cache ca-certificates
RUN  apk add gettext libintl && apk add curl

WORKDIR /opt/lacchain/rotation-validator

COPY ./files/config.toml /opt/lacchain/rotation-validator/config.toml.template
RUN chmod 0644 /opt/lacchain/rotation-validator/config.toml.template
COPY --from=builder /go/bin /opt/lacchain/rotation-validator
COPY ./files/start-rotation.sh /opt/lacchain/rotation-validator/start-rotation.sh
RUN chmod 755 /opt/lacchain/rotation-validator/start-rotation.sh
RUN chmod 777 -R /opt/lacchain/rotation-validator
ENTRYPOINT ["sh", "/opt/lacchain/rotation-validator/start-rotation.sh"]
CMD [ "/opt/lacchain/rotation-validator/client" ]