#!/bin/bash

set -eo pipefail

openssl req -x509 -newkey rsa:4096 -days 3650 -sha256 -nodes \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=ss/ST=ss/L=ss/O=ss/OU=ss/CN=${DOMAIN_NAME}" \
    -addext "subjectAltName = DNS:${DOMAIN_NAME}" \
    -addext "certificatePolicies = 1.2.3.4"