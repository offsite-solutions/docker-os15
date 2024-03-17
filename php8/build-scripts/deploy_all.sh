#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;

docker tag os15-php8-base:latest offsite/os15-php8-base:$VER
docker tag os15-php8-base-dev:latest offsite/os15-php8-base-dev:$VER
docker tag os15-php8-base-dev-debug:latest offsite/os15-php8-base-dev-debug:$VER
docker tag os15-php8-base-nodb:latest offsite/os15-php8-base-nodb:$VER
docker tag os15-php8-base-pgsql:latest offsite/os15-php8-base-pgsql:$VER
docker tag os15-php8-base-oci8:latest offsite/os15-php8-base-oci8:$VER
docker tag os15-php8-base-sqlsrv:latest offsite/os15-php8-base-sqlsrv:$VER

docker push offsite/os15-php8-base:latest
docker push offsite/os15-php8-base:$VER
docker push offsite/os15-php8-base-dev:latest
docker push offsite/os15-php8-base-dev:$VER
docker push offsite/os15-php8-base-dev-debug:latest
docker push offsite/os15-php8-base-dev-debug:$VER
docker push offsite/os15-php8-base-nodb:latest
docker push offsite/os15-php8-base-nodb:$VER
docker push offsite/os15-php8-base-pgsql:latest
docker push offsite/os15-php8-base-pgsql:$VER
docker push offsite/os15-php8-base-oci8:latest
docker push offsite/os15-php8-base-oci8:$VER
docker push offsite/os15-php8-base-sqlsrv:latest
docker push offsite/os15-php8-base-sqlsrv:$VER
