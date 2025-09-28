#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;

docker build \
--force-rm \
--no-cache \
--rm \
-t offsite-dev-debug-php8:$VER -t offsite-dev-debug-php8:latest \
-f Dockerfile.dev-debug .
