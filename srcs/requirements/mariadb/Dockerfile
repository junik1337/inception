FROM	debian:bullseye

RUN		apt update -y && \
		apt install -y mariadb-server 

COPY	./tools/create_db.sh /tmp/

RUN		chmod +x /tmp/create_db.sh

ENTRYPOINT [ "sh", "/tmp/create_db.sh" ]