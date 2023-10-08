#!/bin/bash

set -eo pipefail

bash /conf/configure_wordpress.sh
bash /conf/configure_php.sh

echo "[i] start php"
exec php-fpm7.4 -FOR