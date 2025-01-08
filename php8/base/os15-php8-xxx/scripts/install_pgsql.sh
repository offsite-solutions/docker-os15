#!/bin/bash

zypper --non-interactive --gpg-auto-import-keys install postgresql php8-pgsql php8-pdo

cd /tmp/install

echo "" >> /usr/local/bin/env.sh
echo "# PostgreSQL environments" >> /usr/local/bin/env.sh

printf "# Built with PGSQL ON\n" >> /usr/local/bin/env.sh