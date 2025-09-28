#!/bin/bash

# installing Microsoft SQL server client
#   https://docs.microsoft.com/en-us/sql/connect/php/connection-options?redirectedfrom=MSDN&view=sql-server-ver15
#   https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-2017#suse17
#   https://docs.microsoft.com/en-us/sql/connect/php/installation-tutorial-linux-mac?view=sql-server-2017#installing-the-drivers-on-suse-12-and-15

zypper --non-interactive --gpg-auto-import-keys install php8-pecl php8-devel php8-pdo
curl -O https://packages.microsoft.com/keys/microsoft.asc
rpm --import microsoft.asc
zypper --non-interactive --gpg-auto-import-keys addrepo "https://packages.microsoft.com/config/sles/15/prod.repo"
ACCEPT_EULA=Y zypper --non-interactive --gpg-auto-import-keys install msodbcsql17 glibc-gconv-modules-extra
ACCEPT_EULA=Y zypper --non-interactive --gpg-auto-import-keys install mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

zypper --non-interactive --gpg-auto-import-keys install make unixODBC-devel

pecl channel-update pecl.php.net
pecl install sqlsrv-5.12.0
pecl install pdo_sqlsrv-5.12.0

echo "extension=pdo_sqlsrv.so" >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/pdo_sqlsrv.ini
echo "extension=sqlsrv.so" >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/sqlsrv.ini

cd /tmp/install

# clean up
zypper --non-interactive rm -u php8-pecl php8-devel make

echo "" >> /usr/local/bin/env.sh
echo "# Microsoft SQL Server environments" >> /usr/local/bin/env.sh

printf "# Built with SQLSRV ON\n" >> /usr/local/bin/env.sh
