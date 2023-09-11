FROM	debian:bullseye

RUN		apt update -y && \
		apt install -y php7.4-fpm \
		mariadb-client \
		php-mysql \
		sendmail \
		curl

COPY	./tools/create_wp.sh /tmp

RUN 	chmod +x /tmp/create_wp.sh

RUN		mkdir -p /var/www/html

RUN		mkdir -p /run/php

EXPOSE	9000

ENTRYPOINT [ "sh", "/tmp/create_wp.sh" ]