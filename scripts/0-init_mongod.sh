#!/bin/bash

cd "$(dirname "$0")/.." || exit 1

docker-compose --env-file docker_compose.env -f docker-compose.yaml exec -T mongod0-0 mongo localhost:27018 --eval 'rs.initiate({
   _id : "mongo0",
   members: [
      { _id: 0, host: "mongod0-0:27018" },
      { _id: 1, host: "mongod0-1:27018" },
      { _id: 2, host: "mongod0-arb:27018", arbiterOnly: true }
   ]
})'
