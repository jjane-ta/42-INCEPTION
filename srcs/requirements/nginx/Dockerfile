FROM ubuntu:focal

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl

COPY ./ /
ENTRYPOINT  ["bash", "/docker-entrypoint.sh"]
