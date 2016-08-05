.PHONY: build deploy build-docker-base build-docker-web

build-docker-base:
	docker build -t poc-base:1.0 -f base.docker .

build-docker-web: pull build-docker-base
	docker build -t poc-web:1.0 -f web.docker .

pull:
	git pull origin master

build:
	git pull origin master

deploy:
	@echo "kill the instance and restart or kill -HUP nginx"
