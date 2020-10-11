#!/bin/bash

zypper --non-interactive --gpg-auto-import-keys install postgresql php7-pgsql php7-pdo

pear config-set preferred_state beta
pear install MDB2-2.5.0b5
pear install "pear/MDB2#pgsql"
pear config-set preferred_state stable

echo "" >> /usr/local/bin/env.sh
echo "# PostgreSQL environments" >> /usr/local/bin/env.sh

printf "# Built with PGSQL ON\n" >> /usr/local/bin/env.sh