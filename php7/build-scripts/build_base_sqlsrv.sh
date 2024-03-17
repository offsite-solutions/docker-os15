#!/bin/bash
cwd=$(pwd)

cd ../../base/os15-php74-xxx \
&&
docker build \
--progress=plain \
--force-rm \
--no-cache \
--rm \
--build-arg with_xdebug=FALSE --build-arg with_composer=TRUE --build-arg with_oci8=FALSE --build-arg with_pgsql=FALSE --build-arg with_sqlsrv=TRUE \
-t os15-php74-base-sqlsrv:latest . \
&&
docker tag os15-php74-base-sqlsrv:latest offsite/os15-php74-base-sqlsrv:latest \
&&
cd $cwd || exit
