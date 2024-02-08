#!/bin/bash
apt-get update
DEBIAN_FRONTEND="noninteractive" apt-get install -y mysql-server

# Set MySQL root password
MYSQL_ROOT_PASSWORD='root'

# Secure MySQL installation
mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" <<EOF
UPDATE mysql.user SET authentication_string=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;
EOF

# Create a database and user for interaction
MYSQL_USER='warda'
MYSQL_PASSWORD='warda'
MYSQL_DATABASE='warda'

mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE ${MYSQL_DATABASE};
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
