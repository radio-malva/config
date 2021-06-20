#! /bin/bash

set -eu


while ! nc -z localhost 1883  
do
	echo Waiting for mosquitto...
	sleep 1
done
##FIXME: max retries

cd "$(dirname "$0")"
pwd
daemon --name rstp  -P /tmp --chdir $PWD  -o rtsp.log -r -- $PWD/start-rtsp.sh

