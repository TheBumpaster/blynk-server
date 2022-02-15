# Blynk Server Dockerized Setup
PostgreSQL DB is running inside the same container as the Blynk Server is being installed. So data can be migrated from one db source to another if needed.

## Install Docker & Docker Compose
[Docker](https://docs.docker.com/get-docker/) is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly.

[Docker Compose](https://docs.docker.com/compose/install/) relies on Docker Engine for any meaningful work, so make sure you have Docker Engine installed either locally or remote, depending on your setup.

__Say goodbye to sprawling docker commands and say hello to `/$ docker-compose up`__

## Runtime

### **Setup env keys**
Checkout the content of [.env](.env) file in the root directory.
Set your prefered version to `BLYNK_SERVER_VERSION` 

```env
BLYNK_SERVER_VERSION="0.41.17"
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
**Create a volume and a network to be used by Blynk**

- `docker network create blynk_network`
- `docker volume create blynk_volume`

Or change the network and volumes in docker-compose.yaml to attach it to another stack.

### **Build**
Build docker image with docker-compose to generate both postgres db and the server, detaching from terminal. Docker compose will load up our env keys in the docker run command:

- `docker-compose up -d`

That is it, you are running on your docker network.

You can also build and run the Dockerfile without postgres db and load it's host and port, but you need to pre-load the env keys or programatically generate docker run command e.g:

- `docker build --build-arg BLYNK_SERVER_VERSION=0.41.17 --build-arg DB_HOST=localhost --build-arg DB_PORT=5432 -t blynk_server:latest .`

<br/>

- `docker run --env-file .env.local -p 8440:8440 -p 8080:8080 -p 9443:9443 -v blynk_volume:/data --network blynk_network blynk_server:latest`

### Logs

- `docker exec blynk-server cat /data/logs/blynk.log`
- `docker exec blynk-server cat /data/logs/postgres.log`
- `docker exec blynk-server cat /data/logs/stats.log`
- `docker exec blynk-server cat /data/logs/worker.log`
