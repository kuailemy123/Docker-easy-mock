#!/bin/sh -x

set -o errexit

CONFIG_FILE=/usr/local/easy-mock/config/default.json
/bin/sed -i "s|\"port\": 7300|\"port\": ${PORT}|g" $CONFIG_FILE
/bin/sed -i "s|mongodb://localhost|mongodb://${MONGODB}|g" $CONFIG_FILE
/bin/sed -i "s|mongodb://localhost|mongodb://${MONGODB}|g" $CONFIG_FILE
/bin/sed -i "s|\"port\": 6379|\"port\": ${REDIS_PORT}|g" $CONFIG_FILE
/bin/sed -i "s|\"host\": \"localhost\"|\"host\": \"${REDIS_HOST}\"|g" $CONFIG_FILE
/bin/sed -i "s|\"password\": \"\"|\"password\": \"${REDIS_PASSWORD}\"|g" $CONFIG_FILE
/bin/sed -i "s|\"db\": 0|\"db\": ${REDIS_DB}|g" $CONFIG_FILE

cd /usr/local/easy-mock/ && npm run dev