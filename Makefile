ENV_FILE=./srcs/.env
include ${ENV_FILE}

NAME=inception
DATA_PATH=${PWD}/data

COMPOSE=docker compose -f ./srcs/docker-compose.yml -p ${NAME} 
TRAP=trap 'exit 0' INT;

# default cli values
sh=/bin/bash
proto=https


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
	@sudo bash -c "echo -e '#'${NAME}'\n127.0.0.1\t'${DOMAIN_NAME} >> /etc/hosts"
	@echo "[i] ADDED host domain ${DOMAIN_NAME}"

	@sudo bash -c "echo -e '\nDATA='${DATA_PATH} >> ${ENV_FILE}"
	@echo "[i] ADDED DATA=${DATA_PATH} in ${ENV_FILE}"

	@mkdir -p ${DATA_PATH} && ln -s ${DATA_PATH} $(HOME)/data 
	@echo "[i] LINKED ${DATA_PATH} ---> ${HOME}/data"

tls_test:
	curl -I "${proto}://${DOMAIN_NAME}/cert" -k -v --tlsv1.0 --tls-max ${v}

clean:
	@sudo sed -i "/\<${NAME}\>/,+1d" /etc/hosts
	@sudo sed -i "/\<DATA\>/d" ${ENV_FILE}
	@sudo sed -i "/^$$/d" ${ENV_FILE}


	@rm -f ${HOME}/data 
	@echo "[i] REMOVED data_link, data_path and host domain ${DOMAIN_NAME}"
fclean: clean
	@sudo rm -fr ${PWD}/data
	@echo "[i] REMOVED data folder"

.PHONY: all up down build ps logs exec install tls_test clean fclean 