FROM	debian:bullseye

RUN		apt update -y && \
		apt install -y nginx \
		openssl

RUN		mkdir -p /etc/nginx/ssl

RUN 	openssl req -x509 -nodes \
		-out /etc/nginx/ssl/inception.crt \
		-keyout /etc/nginx/ssl/inception.key \
		-subj "/C=MA/L=Khouribga/O=1337/CN=ayassir.42.fr"

COPY	./conf/nginx.conf /etc/nginx/conf.d
COPY	./tools/404.html /var/www/html
COPY	./tools/502.html /var/www/html

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]