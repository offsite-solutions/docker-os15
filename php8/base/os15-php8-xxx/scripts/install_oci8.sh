#!/bin/bash

# https://en.opensuse.org/SDB:Howto_build_oci8_extension_module_for_php

printf "# Built with OCI8 ON\n" >> /usr/local/bin/env.sh

# checking required files
if [ ! -f "/tmp/install/oci8/oracle-instantclient-basic-21.13.0.0.0-1.x86_64.rpm" ]; then printf "\n\n!!! Missing install file: oracle-instantclient-basic-21.13.0.0.0-1.x86_64.rpm\n\n"; exit 1; fi
if [ ! -f "/tmp/install/oci8/oracle-instantclient-devel-21.13.0.0.0-1.x86_64.rpm" ]; then printf "\n\n!!! Missing install file: oracle-instantclient-devel-21.13.0.0.0-1.x86_64.rpm \n\n"; exit 1; fi

zypper --non-interactive --gpg-auto-import-keys install php8-pecl php8-devel php8-pdo libaio1 make gcc
rpm -ivh /tmp/install/oci8/oracle-instantclient-basic-21.13.0.0.0-1.x86_64.rpm /tmp/install/oci8/oracle-instantclient-devel-21.13.0.0.0-1.x86_64.rpm

export ORACLE_HOME=/usr/lib/oracle/21/client64
export TNS_ADMIN=/usr/lib/oracle/21/client64
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8

pecl channel-update pecl.php.net

echo 'instantclient,/usr/lib/oracle/21/client64/lib' | pecl install oci8

echo "extension=oci8.so" >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/oci8.ini

echo 'instantclient,/usr/lib/oracle/21/client64/lib' | pecl install pdo_oci

echo "extension=pdo_oci.so" >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/pdo_oci.ini

cd /tmp/install

echo "" >> /usr/local/bin/env.sh
echo "# ORACLE OCI8 environments" >> /usr/local/bin/env.sh
echo "export ORACLE_HOME=/usr/lib/oracle/21/client64" >> /usr/local/bin/env.sh
echo "export TNS_ADMIN=/usr/lib/oracle/21/client64" >> /usr/local/bin/env.sh
echo "export NLS_LANG=AMERICAN_AMERICA.AL32UTF8" >> /usr/local/bin/env.sh

# clean up
zypper --non-interactive rm -u php8-pecl php8-devel gcc make

printf "# Built with OCI8 ON\n" >> /usr/local/bin/env.sh