# https://wiki.ubuntu.com/Releases
FROM ubuntu:focal

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y mariadb-server mariadb-client

COPY ./ /
ENTRYPOINT  ["bash", "/docker-entrypoint.sh"]
