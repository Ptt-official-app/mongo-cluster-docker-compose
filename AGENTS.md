# Repository Guidelines

## Project Overview
`Ptt-official-app/mongo-cluster-docker-compose`: docker-compose definition of a small sharded MongoDB cluster (mongo:4.4.2) for local/dev use. One shard replica set (`mongo0`: two data members plus one arbiter), a config server replica set (`mongo-configsvr`, three members), and two `mongos` routers. Shell scripts initialize the replica sets and register the shard. Licensed GPL-3.0.

## Architecture & Data Flow
- `mongod0-0`, `mongod0-1`, `mongod0-arb` (port 27018, `clusterRole: shardsvr`, replica set `mongo0`).
- `mongocfg-0/1/2` (port 27019, `clusterRole: configsvr`, replica set `mongo-configsvr`).
- `mongos-0`, `mongos-1` use `sharding.configDB` from `etc/mongo/mongos.conf`; published only on `127.0.0.1:27017` and `127.0.0.1:27027`.
- Replica sets are not initialized automatically: after `up -d`, run `scripts/0-init_mongod.sh` (shard rs), `scripts/1-init_mongocfg.sh` (config rs), then `scripts/2-add-shard0.sh` (`sh.addShard` through `mongos-0`), in that order.

## Key Directories
- `etc/mongo/`: `mongod0.conf`, `mongocfg.conf`, `mongos.conf`, bind-mounted into containers as `/etc/mongod.conf` / `/etc/mongos.conf`.
- `scripts/`: numbered init scripts (`0-`, `1-`, `2-`).
- `var/lib/mongo/`: per-node data directories (bind-mounted to `/data/db`); only `.exists` placeholders are tracked, contents are gitignored.

## Development Commands
```
cp docker_compose.env.template docker_compose.env      # then edit
docker-compose --env-file docker_compose.env -f docker-compose.yaml up -d
docker-compose --env-file docker_compose.env -f docker-compose.yaml config -q   # validate compose file
scripts/0-init_mongod.sh && scripts/1-init_mongocfg.sh && scripts/2-add-shard0.sh
shellcheck scripts/*.sh
```

## Code Conventions & Common Patterns
- Compose services: one block per node, all using `mongo:4.4.2`, CPU/memory limits and reservations from env vars (`MONGOD_*`, `MONGOD_ARB_*`, `MONGOCFG_*`, `MONGOS_*`), `restart: always`.
- Paths and resource sizes are parameterized in `docker_compose.env` (git-ignored); keep `docker_compose.env.template` in sync when adding variables.
- When adding or renaming a node, update the compose file, the matching `rs.initiate` member list in the init script, and `mongos.conf` `configDB` if it is a config server.
- Config files keep commented-out TLS/x509 examples; TLS is disabled by default.
- Scripts are `#!/bin/bash`, one `mongo --eval` call each.

## Important Files
`docker-compose.yaml`, `docker_compose.env.template`, `etc/mongo/*.conf`, `scripts/*.sh`, `README.md` (English and Traditional Chinese usage).

## Runtime/Tooling Preferences
- Docker with `docker-compose` (the `--env-file` flag is used in README).
- Image `mongo:4.4.2` (includes the legacy `mongo` shell used by the scripts).
- Default resource limits (e.g. `MONGOD_MEM=24G`) are large; lower them in `docker_compose.env` for small machines.

## Testing & QA
No automated tests or CI. Verify changes manually: validate with `docker-compose ... config -q`, run `shellcheck scripts/*.sh`, bring the stack up, run the three init scripts, and check `rs.status()` on each replica set and `sh.status()` via `mongos`.
