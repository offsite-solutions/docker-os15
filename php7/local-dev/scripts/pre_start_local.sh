#!/bin/bash

printf "\nRunning Local pre-start script...\n"

# linking apache configurations
printf "\nLinking Apache2 configuration files...\n"
find /host/dockerconfig/etc/apache2/conf.d/ -name "*.conf" -exec ln -sf {} /etc/apache2/conf.d/ \;

# linking virtualhost configs
printf "Linking Apache2 VirtualHost configurations...\n"
find /host/dockerconfig/etc/apache2/vhosts.d/ -name "*.conf" -exec ln -sf {} /etc/apache2/vhosts.d/ \;

# extra hosts files
printf "Adding extra hosts definitions... \n"
cat /host/dockerconfig/etc/hosts >> /etc/hosts

# linking tnsadmin
printf "Linking ORACLE TNS_ADMIN...\n"
ln -sf /host/dockerconfig/instantclient/tnsnames.ora /usr/lib/oracle/19.8/client64/

# Creating phpinfo into server root
printf "Creating phpinfo, access as 'http://localhost:nnn/phpinfo.php' ...\n"
echo "<?php phpinfo();" > /srv/www/htdocs/phpinfo.php;

# Turning off server hardening
printf "Turning off Apache hardening ...\n"
mv /etc/apache2/conf.d/hardening.conf /etc/apache2/conf.d/hardening.conf-off

# Fix links
printf "Fix symbolic links under /host directory ...\n"
mkdir -p /Users/baxi
ln -sf /host /Users/baxi/Work

# Creating log directory
#printf "Creating application log directory (/var/log/application/)...\n"
#mkdir -p /var/log/application
#chown www:wwwrun /var/log/application

printf "\nPre-start script finished\n\n"