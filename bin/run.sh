#!/bin/bash

set -e

#
# Generate server.properties values based on environment keys
echo "hardware.mqtt.port=${HARDWARE_MQTT_PORT}
hardware.ssl.port=${HARDWARE_MQTT_PORT_SSL}
http.port=${HTTP_PORT}
force.port.80.for.csv=${FORCE_PORT_80_FOR_CSV}
force.port.80.for.redirect=${FORCE_PORT_80_FOR_REDIRECT}
https.port=${HTTPS_PORT}
server.ssl.cert=${SERVER_SSL_CERT}
server.ssl.key=${SERVER_SSL_KEY}
server.ssl.key.pass=${SERVER_SSL_KEY_PASS}
data.folder=${DATA_FOLDER}
logs.folder=./logs
log.level=${LOG_LEVEL}
user.devices.limit=${USER_DEVICES_LIMIT}
user.tags.limit=${USER_TAGS_LIMIT}
user.dashboard.max.limit=${USER_DASHBOARD_MAX_LIMIT}
user.widget.max.size.limit=${USER_WIDGET_MAX_SIZE_LIMIT}
user.message.quota.limit=${USER_MESSAGE_QUOTA_LIMIT}
notifications.queue.limit=${NOTIFICATIONS_QUEUE_LIMIT}
blocking.processor.thread.pool.limit=${BLOCKING_PROCESSOR_THREAD_POOL_LIMIT}
notifications.frequency.user.quota.limit=${NOTIFICATIONS_FREQUENCY_USER_QUOTA_LIMIT}
webhooks.frequency.user.quota.limit=${WEBHOOKS_FREQUENCY_USER_QUOTA_LIMIT}
webhooks.response.size.limit=${WEBHOOKS_RESPONSE_SIZE_LIMIT}
user.profile.max.size=${USER_PROFILE_MAX_SIZE}
terminal.strings.pool.size=${TERMINAL_STRINGS_POOL_SIZE}
map.strings.pool.size=${MAP_STRINGS_POOL_SIZE}
lcd.strings.pool.size=${LCD_STRINGS_POOL_SIZE}
table.rows.pool.size=${TABLE_ROWS_POOL_SIZE}
profile.save.worker.period=${PROFILE_SAVE_WORKER_PERIOD}
stats.print.worker.period=${STATS_PRINT_WORKER_PERIOD}
web.request.max.size=${WEB_REQUEST_MAX_SIZE}
csv.export.data.points.max=${CSV_EXPORT_DATA_POINTS_MAX}
hard.socket.idle.timeout=${HARD_SOCKET_IDLE_TIMEOUT}
enable.db=${ENABLE_DB}
enable.raw.db.data.store=${ENABLE_RAW_DB_DATA_STORE}
async.logger.ring.buffer.size=${ASYNC_LOGGER_RING_BUFFER_SIZE}
allow.reading.widget.without.active.app=${ALLOW_READING_WIDGET_WITHOUT_ACTIVE_APP}
allow.store.ip=${ALLOW_STORE_IP}
initial.energy=${INITIAL_ENERGY}
admin.rootPath=${ADMIN_ROOT_PATH}
restore.host=${RESTORE_HOST}
product.name=${PRODUCT_NAME}
admin.email=${ADMIN_EMAIL}
admin.pass=${ADMIN_PASS}
server.host=${SERVER_HOST}
contact.email=${CONTACT_EMAIL}
" > /config/server.properties

#
# Generate db.properties values based on environment keys
echo "jdbc.url=${DB_URL}
user=${DB_USER}
password=${DB_PASSWORD}
connection.timeout.millis=${DB_TIMEOUT}
clean.reporting=${DB_CLEAN_REPORTING}
reporting.jdbc.url=${DB_REPORTING_URL}
reporting.user=${DB_REPORTING_USER}
reporting.password=${DB_REPORTING_PASSWORD}
reporting.connection.timeout.millis=${DB_REPORTING_TIMEOUT}" > /blynk/db.properties

ln -s /blynk/db.properties /config/db.properties

#
# Generate mail.properties values based on environment keys
echo "mail.smtp.auth=${MAIL_SMTP_AUTH}
mail.smtp.starttls.enable=${MAIL_SMTP_STARTTLS_ENABLE}
mail.smtp.host=${MAIL_SMTP_HOST}
mail.smtp.port=${MAIL_SMTP_PORT}
mail.smtp.username=${MAIL_SMTP_USERNAME}
mail.smtp.password=${MAIL_SMTP_PASSWORD}
mail.smtp.connectiontimeout=${MAIL_SMTP_CONNECTION_TIMEOUT}
mail.smtp.timeout=${MAIL_SMTP_TIMEOUT}" > /blynk/mail.properties

ln -s /blynk/mail.properties /config/mail.properties

# Start the blynk server
java -jar /blynk/server.jar -dataFolder /data -serverConfig /config/server.properties