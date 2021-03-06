APP = app
DOCKER_COMPOSE = docker-compose
RUN = $(DOCKER_COMPOSE) run --rm ${APP}
RUN_SHELL = $(RUN) bash -c
DOCKER = docker

all: re

build: clean
	$(DOCKER_COMPOSE) build

start:
	$(DOCKER_COMPOSE) up --no-recreate -d

stop:
	$(DOCKER_COMPOSE) kill || true

clean: stop
	$(DOCKER_COMPOSE) rm -afv

re: stop clean build start

sync:
	rsync -a --delete benoit:ets-bollery/wp-content/themes/ ./wp-content/themes
	rsync -a --delete benoit:ets-bollery/wp-content/uploads/ ./wp-content/uploads

rm: clean

ps:
	$(DOCKER_COMPOSE) ps
