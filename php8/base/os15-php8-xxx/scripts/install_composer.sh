#!/bin/bash

zypper --non-interactive --gpg-auto-import-keys install php-composer2
composer selfupdate

printf "# Built with COMPOSER ON\n" >> /usr/local/bin/env.sh