FROM ubuntu:focal

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y php-fpm php-mysql curl  nginx mysql-client
RUN apt install -y php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip

RUN curl https://wordpress.org/latest.tar.gz |  tar zx -C /

COPY ./ /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT  ["/docker-entrypoint.sh"]