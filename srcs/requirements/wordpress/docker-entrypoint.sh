#!/bin/bash

set -eo pipefail

if [[  "$(ls /var/www/jjane-ta.42.fr/)" == "" ]];then
    echo "[i] Installing wordpress"
    cp -a /wordpress/* /var/www/jjane-ta.42.fr
    # chown -R www-data:www-data /var/www/jjane-ta.42.fr 
fi
rm -fr wordpress /latest.tar.gz


WP_DEBUG="true"
DB_HOST=mariadb
WP_CONF_FILE=/var/www/jjane-ta.42.fr/wp-config.php

echo "[i] Configuring wordpress"

echo '<?php'  > $WP_CONF_FILE # HEATHER

cat << BODY >> $WP_CONF_FILE # VARS
define( 'DB_NAME', '$MYSQL_DATABASE' );
define( 'DB_USER', '$MYSQL_USER' );
define( 'DB_PASSWORD', '$MYSQL_PASSWORD' );
define( 'DB_HOST', '$DB_HOST' );
define( 'WP_DEBUG', $WP_DEBUG );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define( 'FS_METHOD', 'direct' );
BODY

curl -s https://api.wordpress.org/secret-key/1.1/salt/  >> $WP_CONF_FILE # KEYS 

# cat << 'HTTPS' >> $WP_CONF_FILE # PROPERLY END FILE CONF
# $_SERVER['HTTP_X_FORWARDED_PROTO']
# $_SERVER['HTTP_X_FORWARDED_PROTO']= 'https'

# $_SERVER['HTTPS'] = 'on';
# HTTPS

cat << 'FOOTER' >> $WP_CONF_FILE # PROPERLY END FILE CONF
$table_prefix = 'sgf69xjd64sdf5__';
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
FOOTER



PHP_CONF_FILE=/etc/php/7.4/fpm/pool.d/www.conf
rm $PHP_CONF_FILE
cat << EOF >> $PHP_CONF_FILE
[www]
user = root
group = root
listen = 9000
;listen.allowed_clients = 0.0.0.0
;listen.owner = root
;listen.group = root
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
EOF


echo "[i] start nginx"
nginx

echo "[i] start php"
exec php-fpm7.4 -FOR