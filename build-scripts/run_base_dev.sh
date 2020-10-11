#!/bin/bash
VER=$1

# PHPStorm remote debugging
# https://www.pascallandau.com/blog/setup-phpstorm-with-xdebug-on-docker/
# https://dev.to/brpaz/docker-phpstorm-and-xdebug-the-definitive-guide-14og

docker rm -f offsite_base_dev & docker run -d -p 10080:80 -p 9010:9010 -p 10443:443 --name offsite_base_dev --entrypoint /usr/local/bin/start.sh os15-php74-dev:$VER
