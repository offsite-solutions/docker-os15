#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;
cwd=$(pwd)

cd ../base/os15-php8-xxx \
&&
docker build \
--progress=plain \
--force-rm \
--no-cache \
--rm \
--build-arg with_xdebug=FALSE --build-arg with_composer=TRUE --build-arg with_oci8=FALSE --build-arg with_pgsql=TRUE --build-arg with_sqlsrv=FALSE \
-t os15-php8-base-pgsql:latest . \
&&
docker tag os15-php8-base-pgsql:latest offsite/os15-php8-base-pgsql:$VER \
&&
cd $cwd || exit
