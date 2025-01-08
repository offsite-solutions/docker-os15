#!/bin/bash

#if [ ! -f "/tmp/install/etc/php8/conf.d/000_xdebug.ini" ]; then printf "\n\n!!! Missing install file: /tmp/install/etc/php8/conf.d/000_xdebug.ini\n\n"; exit 1; fi

zypper --non-interactive --gpg-auto-import-keys install php8-xdebug

cp /tmp/install/etc/php8/conf.d/000_xdebug.ini /etc/php8/conf.d/000_xdebug.ini

# clean up
zypper --non-interactive clean -a

printf "# Built with XDEBUG ON\n" >> /usr/local/bin/env.sh

