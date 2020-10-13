#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;

docker build \
--force-rm \
--no-cache \
--rm \
-t offsite-dev-debug:$VER -t offsite-dev-debug:latest \
-f Dockerfile.dev-debug .
