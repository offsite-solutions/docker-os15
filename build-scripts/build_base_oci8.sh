#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;
cwd=$(pwd)

cd ../base/os15-php74-xxx \
&&
docker build \
--progress=plain \
--force-rm \
--no-cache \
--rm \
--build-arg with_xdebug=FALSE --build-arg with_composer=TRUE --build-arg with_oci8=TRUE --build-arg with_pgsql=FALSE --build-arg with_sqlsrv=FALSE \
-t os15-php74-base-oci8:latest . \
&&
docker tag os15-php74-base-oci8:latest offsite/os15-php74-base-oci8:latest \
&&
cd $cwd || exit
