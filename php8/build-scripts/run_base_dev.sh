#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;

# PHPStorm remote debugging
# https://www.pascallandau.com/blog/setup-phpstorm-with-xdebug-on-docker/
# https://dev.to/brpaz/docker-phpstorm-and-xdebug-the-definitive-guide-14og

RUNNING=$(docker inspect --format="{{ .State.Running }}" offsite_base_dev8 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "offsite_base_dev8 does not exist."
else
  docker rm --force offsite_base_dev8
fi

docker run -d \
       -p 20080:80 \
       -p 29010:9010 \
       -p 20443:443 \
       --name offsite_base_dev8 \
       --entrypoint /usr/local/bin/start.sh \
       os15-php8-base-dev:$VER;
