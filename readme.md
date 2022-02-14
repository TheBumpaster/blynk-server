# Blynk Server Dockerized Setup
PostgreSQL DB is running inside the same container as the Blynk Server is being installed. So data can be migrated from one db source to another if needed.

## Install Docker & Docker Compose
[Docker](https://docs.docker.com/get-docker/) is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly.

[Docker Compose](https://docs.docker.com/compose/install/) relies on Docker Engine for any meaningful work, so make sure you have Docker Engine installed either locally or remote, depending on your setup.

## Runtime

### Setup blynk server version
Checkout the arguments defined in `docker-compose.yaml:L10`

Set your prefered version to `BLYNK_SERVER_VERSION: "0.41.16"`

### Setup env keys
Checkout the content of [.env](.env) file in the root directory.
```env
...
SERVER_HOST=yourhost.com
CONTACT_EMAIL=your@email.com
...
ENABLE_DB=true
ENABLE_RAW_DB_DATA_STORE=true
...
INITIAL_ENERGY=10000000
ADMIN_EMAIL=your@email.com
ADMIN_PASS=admin
```

### Create Volume and Network

- `docker network create blynk_network`
- `docker volume create blynk_volume`

### Build docker image with docker-compose
Docker compose can load up our env keys in the docker run command

- `docker-compose up --build -d`

That is it, you are running on your docker network.

### Logs

- `docker exec blynk-server cat /data/logs/blynk.log`
- `docker exec blynk-server cat /data/logs/postgres.log`
- `docker exec blynk-server cat /data/logs/stats.log`
- `docker exec blynk-server cat /data/logs/worker.log`
