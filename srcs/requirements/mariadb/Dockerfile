# https://wiki.ubuntu.com/Releases
FROM ubuntu:focal

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y mariadb-server mariadb-client

# 0.0.0.0 por wordpress
# RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf


COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]