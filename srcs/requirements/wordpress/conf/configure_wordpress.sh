#!/bin/bash

set -eo pipefail

if [[  "$(ls /var/www/html/)" == "" ]];then
    echo "[i] Installing wordpress"
    cp -a /wordpress/* /var/www/html
fi
rm -fr wordpress /latest.tar.gz


WORDPRESS_CONF_FILE=/var/www/html/wp-config.php

echo "[i] Configuring wordpress"

echo '<?php'  > $WORDPRESS_CONF_FILE # HEATHER

cat << BODY >> $WORDPRESS_CONF_FILE # VARS
define( 'DB_NAME', '$MYSQL_DATABASE' );
define( 'DB_USER', '$MYSQL_USER' );
define( 'DB_PASSWORD', '$MYSQL_PASSWORD' );
define( 'DB_HOST', '$MYSQL_DB_HOST' );
define( 'WP_DEBUG', $WORDPRESS_DEBUG );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define( 'FS_METHOD', 'direct' );
BODY

curl -s https://api.wordpress.org/secret-key/1.1/salt/  >> $WORDPRESS_CONF_FILE # KEYS 

cat << 'FOOTER' >> $WORDPRESS_CONF_FILE # PROPERLY END FILE CONF
$table_prefix = 'sgf69xjd64sdf5__';
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
FOOTER