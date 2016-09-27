APP = app
DOCKER_COMPOSE = docker-compose
RUN = $(DOCKER_COMPOSE) run --rm ${APP}
RUN_SHELL = $(RUN) bash -c
DOCKER = docker

all: re

build: clean
	$(DOCKER_COMPOSE) build

start:
	$(DOCKER_COMPOSE) up -d

stop:
	$(DOCKER_COMPOSE) kill || true

clean: stop
	$(DOCKER_COMPOSE) rm -afv

re: stop clean build start

rm: clean

ps:
	$(DOCKER_COMPOSE) ps
