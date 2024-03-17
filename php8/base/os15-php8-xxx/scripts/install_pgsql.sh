#!/bin/bash

zypper --non-interactive --gpg-auto-import-keys install postgresql php8-pgsql php8-pdo

cd /tmp/install

pear config-set preferred_state beta
pear channel-update pear.php.net
pear install MDB2-2.5.0b5.tgz
pear install MDB2_Driver_pgsql-1.5.0b4.tgz
pear config-set preferred_state stable

echo "" >> /usr/local/bin/env.sh
echo "# PostgreSQL environments" >> /usr/local/bin/env.sh

printf "# Built with PGSQL ON\n" >> /usr/local/bin/env.sh