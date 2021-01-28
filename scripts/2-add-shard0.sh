#!/bin/bash

docker exec mongo-cluster-docker-compose_mongos-0_1 mongo localhost:27017 --eval 'sh.addShard("mongo0/mongod0-0:27018,mongod0-1:27018")'
