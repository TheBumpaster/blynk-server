#!/bin/bash

curl -L https://raw.githubusercontent.com/blynkkk/blynk-server/v${BLYNK_SERVER_VERSION}/server/core/src/main/resources/create_schema.sql > /tmp/create_schema.sql
curl -L https://raw.githubusercontent.com/blynkkk/blynk-server/v${BLYNK_SERVER_VERSION}/server/core/src/main/resources/reporting_schema.sql > /tmp/reporting_schema.sql

createdb ${DB_USER}

PGPASSWORD=${DB_PASSWORD} psql -a -w -U ${DB_USER} -f /tmp/create_schema.sql

echo "Successfully inserted Blynk Server Schema & Tables"

PGPASSWORD=${DB_PASSWORD} psql -a -w -U ${DB_USER} -f /tmp/reporting_schema.sql

echo "Successfully inserted Blynk Server Reporting Schema & Tables"
