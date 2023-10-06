NAME=inception
DOMAIN=jjane-ta.42.fr

COMPOSE=docker compose -f ./srcs/docker-compose.yml -p ${NAME} 

TRAP=trap 'exit 0' INT;
sh=/bin/bash

all: build

up: 
	${COMPOSE} up -d
down:
	${COMPOSE} down
build: 
	${COMPOSE} up -d --build --remove-orphans
ps: 
	${COMPOSE} ps -a
logs:
	@${TRAP} ${COMPOSE} logs ${s} --follow 2> /dev/null
exec:
	@${COMPOSE} exec -ti ${s} ${sh}
	

install: clean
	@sudo bash -c "echo -e '#'${NAME}'\n127.0.0.1\t'${DOMAIN} >> /etc/hosts"
	@echo "[i] ADDED host domain ${DOMAIN}"

	@mkdir -p ${PWD}/data && ln -s ${PWD}/data $(HOME)/data 
	@echo "[i] LINKED data ---> ${HOME}/data"

clean:
	@sudo sed -i "/\<${NAME}\>/,+1d" /etc/hosts
	@rm -f ${HOME}/data 
	@echo "[i] REMOVED data_link and host domain ${DOMAIN}"
fclean: clean
	@sudo rm -fr ${PWD}/data
	@echo "[i] REMOVED data folder"

.PHONY: all up down clean fclean install