#!/bin/bash
cwd=$(pwd)

cd ../base/os15-php74-xxx \
&&
docker build \
--force-rm \
--no-cache \
--rm \
--build-arg with_xdebug=FALSE --build-arg with_composer=TRUE --build-arg with_oci8=TRUE --build-arg with_pgsql=TRUE --build-arg with_sqlsrv=TRUE \
-t os15-php74-base-dev:latest . \
&&
docker tag os15-php74-base-dev:latest offsite/os15-php74-base-dev:latest \
&&
cd $cwd || exit
