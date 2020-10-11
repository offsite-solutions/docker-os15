#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;
cwd=$(pwd)

cd ../base/os15-php74 \
&&
docker build \
--force-rm \
--rm \
-t os15-php74-base:$VER -t os15-php74-base:latest . \
&&
cd "$cwd" || exit
