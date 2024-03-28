#!/bin/bash

if [ ! -d "./shared" ]
then
    mkdir ./shared
fi

if [ ! -d "./QQ" ]
then
    mkdir ./QQ
fi

echo "USER_ID=$(id -u $USER)" >> .env
echo "USER_DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS#*=}" >> .env
echo "USER_PULSE_SERVER=/var/run/user/$(id -u $USER)/pulse/native" >> .env
echo "HOSTNAME=$(hostnamectl hostname)" >> .env
echo "TIMEZONE=$(timedatectl show -p Timezone --value)" >> .env
