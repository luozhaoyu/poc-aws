.PHONY: build deploy build-docker-base build-docker-web clean-all-containers stop-all-containers see-latest-container

build-docker-base:
	docker build -t poc-base:1.0 -f base.docker .

build-docker-web: pull build-docker-base
	docker build -t poc-aws:latest -f web.docker .

run: build-docker-web
	docker run -it -d poc-aws:latest

# attach to latest container
LATEST_CONTAINER=$(shell docker ps -l -q)
see-latest-container: run
	docker exec -it $(LATEST_CONTAINER) /bin/bash

pull:
	git pull origin master

build:
	git pull origin master

deploy:
	@echo "kill the instance and restart or kill -HUP nginx"

ALL_CONTAINERS=$(shell docker ps -a -q) 
stop-all-containers:
	docker stop $(ALL_CONTAINERS)
clean-all-containers: stop-all-containers
	docker rm $(ALL_CONTAINERS)
