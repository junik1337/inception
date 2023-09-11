#!/bin/sh

GREEN='\033[1;32m'
NC='\033[0m'

sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/7.4/fpm/pool.d/www.conf


if [ ! -f "/var/www/html/wp-config.php" ]
then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	cd /var/www/html
	wp core download --path=/var/www/html --allow-root

	wp config create  --dbname=$DB_NAME \
					--dbuser=$DB_USER \
					--dbpass=$DB_PASS \
					--dbhost=$DB_HOST \
					--allow-root

	wp core install --url=$DOMAIN_NAME \
					--title="0xjunik's website" \
					--admin_user=$ADMIN_USER \
					--admin_password=$ADMIN_PASS \
					--admin_email=$ADMIN_EMAIL \
					--allow-root

	wp theme install inspiro --activate --allow-root

	wp user create	$WP_USER $WP_EMAIL \
					--user_pass=$WP_PASS \
					--role=$WP_ROLE \
					--allow-root

	echo "${GREEN}WORDPRESS INSTALLATION FINISHED.${NC}"
else
	echo "${GREEN}WORDPRESS IS ALREADY INSTALLED.${NC}"
fi


/usr/sbin/php-fpm7.4 -F
