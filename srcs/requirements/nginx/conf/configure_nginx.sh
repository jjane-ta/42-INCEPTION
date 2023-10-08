#!/bin/bash

NGINX_CONFIG_FILE=/etc/nginx/conf.d/server.conf
FASTCGI_HOST=wordpress
FASTCGI_PORT=9000
DOLLAR='$'

unlink /etc/nginx/sites-enabled/default
cp /conf/snippets/* /etc/nginx/snippets

cat << EOF > $NGINX_CONFIG_FILE
server {
    listen 443 ssl ;
    listen [::]:443 ssl;
    include snippets/self-signed.conf;

    server_name ${DOMAIN_NAME} www.${DOMAIN_NAME};
    
    index index.php index.html index.php;
    error_log /dev/stdout info;
    access_log /dev/stdout;
    root /var/www/html;

    location ~ \.php$ {
        try_files ${DOLLAR}uri =404;
        include fastcgi_params;
        fastcgi_pass ${FASTCGI_HOST}:${FASTCGI_PORT};
        fastcgi_param SCRIPT_FILENAME ${DOLLAR}document_root${DOLLAR}fastcgi_script_name;
        fastcgi_param PATH_INFO ${DOLLAR}fastcgi_path_info;
    }

    location /cert {
        alias /etc/ssl/certs/nginx.crt;
    }
}
EOF