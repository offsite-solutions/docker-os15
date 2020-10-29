#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;

docker rm -f offsite_dev; \
docker run -d \
  -v /Users/baxi/Work:/host \
  -v /Users/baxi/Work/dockerlogs/dev/applications:/var/log/applications \
  -v /Users/baxi/Work/dockerlogs/dev/apache2:/var/log/apache2 \
  -p 10080:80 -p 9010:9010 -p 10443:443 -p 10444:10444 \
  --name offsite_dev \
  --entrypoint /usr/local/bin/start.sh \
  offsite-dev:$VER;