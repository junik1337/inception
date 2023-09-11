#!/bin/sh

GREEN='\033[1;32m'
NC='\033[0m'

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

/etc/init.d/mariadb start

if [ ! -d "/var/lib/mysql/$DB_NAME" ]
then
	
	mysql -e "CREATE DATABASE $DB_NAME;
			CREATE USER '$DB_USER' IDENTIFIED BY '$DB_PASS';
			GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER';
			FLUSH PRIVILEGES;"
	mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT';"
	
	echo "${GREEN}MARIADB INSTALLATION FINISHED.${NC}"
else
	echo "${GREEN}MARIADB IS ALREADY INSTALLED.${NC}"
fi

kill `cat /var/run/mysqld/mysqld.pid`

exec mysqld
