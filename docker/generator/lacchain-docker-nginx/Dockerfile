FROM ubuntu:20.04
RUN  apt update 
RUN apt install  gnupg2 -y &&  apt install curl -y  &&  apt install ca-certificates -y  &&  apt install lsb-release -y
RUN echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" |  tee /etc/apt/sources.list.d/nginx.list
RUN curl -fsSL https://nginx.org/keys/nginx_signing.key |  apt-key add -
RUN  apt update 
RUN apt install nginx-common -y && apt install nginx-full -y  && apt install lua5.2 -y  && apt install lua5.2-doc -y \
    &&  apt install liblua5.2-dev -y  && apt install luajit -y  && apt install libnginx-mod-http-lua -y 
RUN apt-get install gettext-base
RUN  mkdir /lacchain && mkdir -m 0644  /lacchain/nginx 
RUN  apt-key fingerprint ABF5BD827BD9BF62
RUN rm /etc/nginx/nginx.conf

COPY ./files/nginx-devnet.conf /etc/nginx/nginx.conf
COPY ./files/nginx-default.conf /etc/nginx/conf.d/default.conf.template

RUN chmod 0644 /etc/nginx/nginx.conf && chmod 774 -R /etc/nginx/conf.d/
RUN mkdir /docker-entrypoint.d

COPY ./files/entrypoint/docker-entrypoint.sh /
COPY ./files/entrypoint/10-listen-on-ipv6-by-default.sh /docker-entrypoint.d
COPY ./files/entrypoint/20-envsubst-on-templates.sh /docker-entrypoint.d
COPY ./files/entrypoint/30-tune-worker-processes.sh /docker-entrypoint.d

ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 80
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off; error_log /dev/stdout info; "]
