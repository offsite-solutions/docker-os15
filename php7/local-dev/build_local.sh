#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;

docker build \
--force-rm \
--no-cache \
--rm \
-t offsite-dev-php7:$VER -t offsite-dev-php7:latest \
-f Dockerfile.dev .