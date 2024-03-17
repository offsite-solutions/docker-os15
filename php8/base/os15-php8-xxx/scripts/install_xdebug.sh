#!/bin/bash

if [ ! -f "/tmp/install/etc/php8/conf.d/000_xdebug.ini" ]; then printf "\n\n!!! Missing install file: /tmp/install/etc/php8/conf.d/000_xdebug.ini\n\n"; exit 1; fi

zypper --non-interactive --gpg-auto-import-keys install php8-devel make gcc gzip
pecl channel-update pecl.php.net

tar -zxvf /tmp/install/xdebug-3.3.1.tgz --directory /tmp
cd /tmp/xdebug-3.3.1/ || exit 1
phpize
./configure
make
cp modules/xdebug.so /usr/lib64/php8/extensions/

cp /tmp/install/etc/php8/conf.d/000_xdebug.ini /etc/php8/conf.d/000_xdebug.ini

# clean up
zypper --non-interactive rm -u php8-devel gcc make

printf "# Built with XDEBUG ON\n" >> /usr/local/bin/env.sh

