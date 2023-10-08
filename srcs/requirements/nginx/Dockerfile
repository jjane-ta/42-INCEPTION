FROM ubuntu:focal

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl


COPY ./conf /conf
RUN bash /conf/configure_certs.sh
RUN bash /conf/configure_nginx.sh

ENTRYPOINT ["nginx","-g", "daemon off;"]
