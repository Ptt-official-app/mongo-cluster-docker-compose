#!/bin/bash

cd "$(dirname "$0")/.." || exit 1

docker-compose --env-file docker_compose.env -f docker-compose.yaml exec -T mongos-0 mongo localhost:27017 --eval 'sh.addShard("mongo0/mongod0-0:27018,mongod0-1:27018")'
