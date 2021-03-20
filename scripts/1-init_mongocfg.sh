#!/bin/bash

docker exec mongo-cluster-docker-compose_mongocfg-0_1 mongo localhost:27019 --eval 'rs.initiate({
   _id : "mongo-configsvr",
   members: [
      { _id: 0, host: "mongocfg-0:27019" },
      { _id: 1, host: "mongocfg-1:27019" },
      { _id: 2, host: "mongocfg-2:27019" }
   ]
})'
