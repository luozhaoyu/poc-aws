#!/bin/sh
sudo apt-get -y install python-dev libmysqlclient-dev
sudo apt-get -y install docker.io
sudo usermod -a -G docker ubuntu
