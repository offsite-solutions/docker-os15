#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;
cwd=$(pwd)

cd ../base/os15-php74-xxx \
&&
docker build \
--force-rm \
--no-cache \
--rm \
--build-arg with_xdebug=FALSE --build-arg with_composer=TRUE --build-arg with_oci8=FALSE --build-arg with_pgsql=TRUE --build-arg with_sqlsrv=FALSE \
-t os15-php74-base-pgsql:$VER -t os15-php74-base-pgsql:latest . \
&&
cd $cwd || exit
