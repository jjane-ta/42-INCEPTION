#!/bin/bash

set -eo pipefail
if [[  "$(ls /var/lib/mysql/)" == "" ]];then

    echo "[i] Init mariaDB . . ."

	mysql_install_db > /dev/null

	/usr/bin/mysqld_safe > /dev/null &
	sleep 10s

    echo "[i] CREATE database ${MYSQL_DATABASE}"
    echo "create database ${MYSQL_DATABASE};" | mysql > /dev/null
    echo "[i] ASSING ${MYSQL_USER} user to database ${MYSQL_DATABASE}"
    echo "GRANT ALL privileges ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%'  IDENTIFIED BY '${MYSQL_PASSWORD}' ;"| mysql  > /dev/null
    echo "FLUSH PRIVILEGES" | mysql  > /dev/null

    echo "[i] Now mariaDB is secure"
    echo -e "\n\n${MYSQL_ROOT_PASSWORD}\n${MYSQL_ROOT_PASSWORD}\n\n" | /usr/bin/mysql_secure_installation  > /dev/null 2> /dev/null

	killall mysqld
	sleep 10s
fi


echo "[i] Setting remote acces"
CURRENT_BIND=$(cat  /etc/mysql/mariadb.conf.d/50-server.cnf  | grep "bind-address")
NEW_BIND="bind-address = $(hostname)"
sed -i s/"$CURRENT_BIND"/"$NEW_BIND"/g /etc/mysql/mariadb.conf.d/50-server.cnf