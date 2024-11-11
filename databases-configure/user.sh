#!/bin/bash

sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo  docker run  -d --name mongo -p  27017:27017 --restart=always chaitu1812/mongo-rhel9
sudo docker run  -d --name redis -p  6379:6379  --restart=always chaitu1812/redis-rhel9
sudo docker run  -d --name mysql -p  3306:3306 -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}  --restart=always chaitu1812/mysql-rhel9
sudo docker run  -d --name rabbitmq -e RABBITMQ_DEFAULT_USER=${RABBITMQ_DEFAULT_USER} -e RABBITMQ_DEFAULT_PASS=${RABBITMQ_DEFAULT_PASS}  -p 5672:5672 -p 5671:5671   --restart=always chaitu1812/rabbitmq-rhel9