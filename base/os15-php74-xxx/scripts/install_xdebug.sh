#!/bin/bash

if [ ! -f "/tmp/install/etc/php7/conf.d/000_xdebug.ini" ]; then printf "\n\n!!! Missing install file: /tmp/install/etc/php7/conf.d/000_xdebug.ini\n\n"; exit 1; fi

zypper --non-interactive --gpg-auto-import-keys install php7-xdebug
cp /tmp/install/etc/php7/conf.d/000_xdebug.ini /etc/php7/conf.d/000_xdebug.ini

printf "# Built with XDEBUG ON\n" >> /usr/local/bin/env.sh

