#!/bin/bash

# https://en.opensuse.org/SDB:Howto_build_oci8_extension_module_for_php

printf "# Built with OCI8 ON\n" >> /usr/local/bin/env.sh

# checking required files
if [ ! -f "/tmp/install/oci8/oracle-instantclient19.8-basic-19.8.0.0.0-1.x86_64.rpm" ]; then printf "\n\n!!! Missing install file: oracle-instantclient19.8-basic-19.8.0.0.0-1.x86_64.rpm\n\n"; exit 1; fi
if [ ! -f "/tmp/install/oci8/oracle-instantclient19.8-devel-19.8.0.0.0-1.x86_64.rpm" ]; then printf "\n\n!!! Missing install file: oracle-instantclient19.8-basic-19.8.0.0.0-1.x86_64.rpm \n\n"; exit 1; fi
if [ ! -f "/tmp/install/oci8/oci8-2.2.0.tgz" ]; then printf "\n\n!!! Missing install file: oci8-2.2.0.tgz\n\n"; exit 1; fi
if [ ! -f "/tmp/install/oci8/usr/share/php7/PEAR/MDB2/Driver/oci8.php" ]; then printf "\n\n!!! Missing install file: oci8.php\n\n"; exit 1; fi

zypper --non-interactive --gpg-auto-import-keys install php7-pecl php7-devel php7-pdo libaio make gcc gzip
rpm -ivh /tmp/install/oci8/oracle-instantclient19.8-basic-19.8.0.0.0-1.x86_64.rpm /tmp/install/oci8/oracle-instantclient19.8-devel-19.8.0.0.0-1.x86_64.rpm

export ORACLE_HOME=/usr/lib/oracle/19.8/client64
export TNS_ADMIN=/usr/lib/oracle/19.8/client64
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8

pecl channel-update pecl.php.net

tar -zxvf /tmp/install/oci8/oci8-2.2.0.tgz --directory /tmp
cd /tmp/oci8-2.2.0/ || exit 1
phpize
./configure -with-oci8=instantclient,/usr/lib/oracle/19.8/client64/lib
make install

echo "extension=oci8.so" >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/oci8.ini

pear config-set preferred_state beta
pear install MDB2-2.5.0b5
pear install "pear/MDB2#oci8"
pear config-set preferred_state stable
mv /usr/share/php7/PEAR/MDB2/Driver/oci8.php /usr/share/php7/PEAR/MDB2/Driver/oci8.php-orig
mv /tmp/install/oci8/usr/share/php7/PEAR/MDB2/Driver/oci8.php /usr/share/php7/PEAR/MDB2/Driver/oci8.php

echo "" >> /usr/local/bin/env.sh
echo "# ORACLE OCI8 environments" >> /usr/local/bin/env.sh
echo "export ORACLE_HOME=/usr/lib/oracle/19.8/client64" >> /usr/local/bin/env.sh
echo "export TNS_ADMIN=/usr/lib/oracle/19.8/client64" >> /usr/local/bin/env.sh
echo "export NLS_LANG=AMERICAN_AMERICA.AL32UTF8" >> /usr/local/bin/env.sh

zypper --non-interactive rm -u gcc

printf "# Built with OCI8 ON\n" >> /usr/local/bin/env.sh