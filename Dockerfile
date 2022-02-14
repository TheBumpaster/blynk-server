from ubuntu

############################################################
# Install OpenJDK
RUN apt update && apt install -y openjdk-11-jdk libxrender1 maven
RUN apt install -y curl

############################################################
# Download Postgres DB
RUN apt update && apt install postgresql postgresql-contrib -y

############################################################
# Download Blynk Server
ARG BLYNK_SERVER_VERSION
ENV BLYNK_SERVER_VERSION ${BLYNK_SERVER_VERSION}
RUN mkdir /blynk
RUN curl -L https://github.com/blynkkk/blynk-server/releases/download/v${BLYNK_SERVER_VERSION}/server-${BLYNK_SERVER_VERSION}.jar > /blynk/server.jar

COPY ./init /tmp/init

RUN mkdir /data
RUN mkdir /config && touch /config/server.properties
VOLUME ["/config", "/data/backup"]

RUN mkdir -p /usr/local/bin
ADD ./bin /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh

EXPOSE ${HARDWARE_MQTT_PORT} ${HARDWARE_MQTT_PORT_SSL} ${HTTP_PORT} ${HTTPS_PORT}

WORKDIR /data
ENTRYPOINT ["/usr/local/bin/run.sh"]