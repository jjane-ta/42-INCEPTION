FROM ubuntu:focal

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl

# RUN rm /etc/nginx/http.d/*
# COPY ./conf/wordpress_server.conf /etc/nginx/http.d/wordpress_server.conf

# RUN sed "s/DOMAIN_NAME/${DOMAIN_NAME}/g" /etc/nginx/nginx.conf


RUN openssl req -x509 -newkey rsa:4096 -days 3650 -sha256 -nodes \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=ss/ST=ss/L=ss/O=ss/OU=ss/CN=jjane-ta" \
    -addext "subjectAltName = DNS:jjane-ta.42.fr" \
    -addext "certificatePolicies = 1.2.3.4" 

RUN unlink /etc/nginx/sites-enabled/default
COPY ./conf/server_test.conf /etc/nginx/conf.d/server_test.conf
COPY ./conf/snippets /etc/nginx/snippets

# RUN sed "s/DOMAIN_NAME/${DOMAIN_NAME}s/g" /etc/nginx/nginx.conf


ENTRYPOINT ["nginx","-g", "daemon off;"]
# ENTRYPOINT sleep infinity
