#!/bin/bash

set -eo pipefail

echo "[i] Configuring php-fpm server"

PHP_CONF_FILE=/etc/php/7.4/fpm/pool.d/www.conf
rm $PHP_CONF_FILE
cat << EOF >> $PHP_CONF_FILE
[www]
user = root
group = root
listen = 9000
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
EOF