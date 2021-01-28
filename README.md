# mongo-cluster-docker-compose
mongo-clluster-docker-compose

## Docker-compose

You can do the following to start with docker-compose:

* copy `docker_compose.env.template` to `docker_compose.env` and modify the settings.
* `./scripts/docker_initbbs.sh [BBSHOME] pttofficialapps/go-pttbbs:latest`
* `docker-compose --env-file docker_compose.env -f docker-compose.yaml up -d`
* setup mongod
* setup mongocfgsvr
* setup mongos

您可以使用以下方式來使用 docker-compose:

* 將 `./docker_compose.env.template` copy 到 `./docker_compose.env` 並且更改 BBSHOME 到您所希望的位置.
* `./scripts/docker_initbbs.sh [BBSHOME] pttofficialapps/go-pttbbs:latest`
* `docker-compose --env-file docker_compose.env -f docker-compose.yaml up -d`
* setup mongod
* setup mongocfgsvr
* setup mongos
