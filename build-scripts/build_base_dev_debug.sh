#!/bin/bash
cwd=$(pwd)

cd ../base/os15-php74-xxx \
&&
docker build \
--progress=plain \
--force-rm \
--no-cache \
--rm \
--build-arg with_xdebug=TRUE --build-arg with_composer=TRUE --build-arg with_oci8=TRUE --build-arg with_pgsql=TRUE --build-arg with_sqlsrv=TRUE \
-t os15-php74-base-dev-debug:latest . \
&&
docker tag os15-php74-base-dev-debug:latest offsite/os15-php74-base-dev-debug:latest \
&&
cd $cwd || exit
