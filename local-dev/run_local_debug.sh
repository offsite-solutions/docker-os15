#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;

docker build \
--force-rm \
--no-cache \
--rm \
-t offsite-dev-debug:$VER -t offsite-dev-debug:latest \
-f Dockerfile.dev-debug . \
&&
docker rm -f offsite_dev_debug; \
docker run -d \
  -v /Users/baxi/Work:/host \
  -v /Users/baxi/Work/dockerlogs/dev_debug/applications:/var/log/applications \
  -v /Users/baxi/Work/dockerlogs/dev_debug/apache2:/var/log/apache2 \
  -p 10081:80 -p 9011:9010 -p 10443:443 \
  --name offsite_dev_debug \
  --entrypoint /usr/local/bin/start.sh \
  offsite-dev-debug:$VER;