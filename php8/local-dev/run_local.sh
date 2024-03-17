#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;

docker rm -f offsite_dev_php8; \
docker run -d \
  -v /Users/baxi/Work:/host \
  -v /Users/baxi/Work/dockerlogs/dev/applications:/var/log/applications \
  -v /Users/baxi/Work/dockerlogs/dev/apache2:/var/log/apache2 \
  -p 15088:80 -p 9510:9010 -p 15443:443 -p 15444:10444 \
  --name offsite_dev_php8 \
  --entrypoint /usr/local/bin/start.sh \
  offsite-dev-php8:$VER;