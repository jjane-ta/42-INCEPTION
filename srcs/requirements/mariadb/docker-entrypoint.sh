#!/bin/bash

set -eo pipefail

bash conf/configure_mariaDb.sh

echo "[i] Starting mariaDB"
exec /usr/bin/mysqld_safe
