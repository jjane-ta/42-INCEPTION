#!/bin/bash

openssl req -x509 -newkey rsa:4096 -days 3650 -sha256 -nodes \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=ss/ST=ss/L=ss/O=ss/OU=ss/CN=jjane-ta" \
    -addext "subjectAltName = DNS:jjane-ta.42.fr" \
    -addext "certificatePolicies = 1.2.3.4"