# mongo-cluster-docker-compose
mongo-clluster-docker-compose

## Docker-compose

You can do the following to start with docker-compose:

* copy `docker_compose.env.template` to `docker_compose.env` and modify the settings.
* `docker-compose --env-file docker_compose.env -f docker-compose.yaml up -d`
* `scripts/0-init_mongod.sh`
* `scripts/1-init_mongocfg.sh`
* `scripts/2-add-shard0.sh`

您可以使用以下方式來使用 docker-compose:

* 將 `./docker_compose.env.template` copy 到 `./docker_compose.env` 並且更改相對應的設定.
* `docker-compose --env-file docker_compose.env -f docker-compose.yaml up -d`
* `scripts/0-init_mongod.sh`
* `scripts/1-init_mongocfg.sh`
* `scripts/2-add-shard0.sh`
