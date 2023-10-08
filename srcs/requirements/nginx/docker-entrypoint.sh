#!/bin/bash

set -eo pipefail

bash /conf/configure_certs.sh
bash /conf/configure_nginx.sh

echo "[i] start nginx"
exec nginx -g "daemon off;"