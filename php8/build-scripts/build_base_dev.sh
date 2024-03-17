#!/bin/bash
cwd=$(pwd)

cd ../../base/os15-php8-xxx \
&&
docker build \
--progress=plain \
--force-rm \
--no-cache \
--rm \
--build-arg with_xdebug=FALSE --build-arg with_composer=TRUE --build-arg with_oci8=FALSE --build-arg with_pgsql=FALSE --build-arg with_sqlsrv=FALSE \
-t os15-php8-base-dev:latest . \
&&
docker tag os15-php8-base-dev:latest offsite/os15-php8-base-dev:latest \
&&
cd $cwd || exit
