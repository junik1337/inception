WORDPRESS_PATH="/home/${USER}/data/wordpress"
MARIADB_PATH="/home/${USER}/data/mariadb"
DATA="/home/${USER}/data"
DOCKER_VOLUME_LIST := $(shell docker volume ls -q)

all:
	@mkdir -p ${DATA}
	@mkdir -p ${WORDPRESS_PATH}
	@mkdir -p ${MARIADB_PATH}
	@docker compose -f ./srcs/docker-compose.yml up -d --wait

down:
	@docker compose -f ./srcs/docker-compose.yml down

up:
	@docker compose -f ./srcs/docker-compose.yml up -d

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

logs:
	@docker compose -f ./srcs/docker-compose.yml logs -f

clean: stop down
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@if [ -n "${DOCKER_VOLUME_LIST}" ]; then \
		docker volume rm $(shell docker volume ls -q); \
	fi
	@sudo rm -rf ${MARIADB_PATH}
	@sudo rm -rf ${WORDPRESS_PATH}
	@sudo rm -rf ${DATA}

re : clean all
