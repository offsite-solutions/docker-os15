# Offsite Solutions :: Base docker images

## Base image
Base image is based on OpenSUSE Leap 15.4, with the following features:

### System apps
- Apache 2.4
- Cronie
- Supervisord
- Network
    - curl
    - telnet
- Runtime editing - debugging
    - Nano
- Archive
    - zip
    - unzip
    - tar
    
### PHP 7.4
- FPM
- PEAR
- OPCache
- Composer

### Application defaults
#### Apache 2.4
    /etc/apache2/conf.d/loadmodule.conf
- Listening on 80
    - SSL preconfigured, but not enabled in the `listener.conf`
- Modules installed and enabled by default
    - filter_module - required for hardening
    - deflate_module - compressed response
    - access_compat_module - for backward Apache 2.2 compatibility
    - rewrite_module - rewrite engine
    - proxy_module - required by PHP-FPM
    - proxy_fcgi_module - required by PHP-FPM
    - headers_module - required for hardening

##### Hardening
    /etc/apache2/conf.d/hardening.conf
Default hardening enabled according to https://geekflare.com/apache-web-server-hardening-security/

###### Denied directories
    /etc/apache2/conf.d/deniedfiles.conf
Access to directories and files starting with a dot (ex: .git, .svn, .htaccess) are denied by default.

##### PHP-FPM
    /etc/apache2/conf.d/fpm.conf
FPM engine configured to listen on TCP:9074 (see later).

##### Response compression
Response compression enabled by default for the following mime types:
- text/plain
- text/html
- text/xml
- text/css
- application/xml
- application/xhtml+xml
- application/rss+xml
- application/javascript
- application/x-javascript
- application/json

#### Logs
Apache logs located in

    /var/log/apache2

### PHP 7.4
The actual version of PHP 7.4 installed with the followings:

#### Modules
- fpm
- openssl
- gd
- bcmath
- mbstring
- json
- zip
- phar
- zlib
- fileinfo
- curl
- pcntl
- ctype
- dom
- iconv
- xmlreader
- xmlwriter
- opcache
- pear
- redis
- soap
- exif

#### php.ini
PHP ini settings found in:

    /etc/php7/conf.d/000_php.ini

#### FPM
FPM configured to listen on TCP:9074

    /etc/php7/fpm/php-fpm.d/default.conf

#### PEAR
    /etc/php7/conf.d/000_pear.ini
PEAR installed with the following modules
- Mail
- Mail_Mime
- Net_SMTP
- MDB2 (beta MDB2-2.5.0b5)

#### OPCache
OPCache is enabled by default

    /etc/php7/conf.d/000_opcache.ini

#### Composer
Composer is an additional module (see later).

#### xDebug
xDebug is an additional module (see later).

#### Logs
PHP and FPM logs located in

    /var/log/apache2/ 

## Scripts deployed
In the build phase every bash script deployed to
 
    /usr/local/bin/
     
### Environment
    /usr/local/bin/env.sh
Empty script, further steps can be included later. The first script executed by the start script.

### Pre-start script
    /usr/local/bin/pre_start.sh
Empty script, further steps can be included later. The second script executed by the start script.

### Start script
    /usr/local/bin/start.sh
Default entrypoint of docker images, executes:
1. env.sh
2. pre_start.sh
3. Starts supervisord

## Supervisord
Supervisord ( http://supervisord.org/ ) ensures that all services started on container run:

    /etc/supervisor.conf

### Services started
#### Apache 2.4
Apache started in foreground mode with
    /usr/sbin/httpd -DFOREGROUND
    
#### PHP-FPM
PHP-FPM engine started in foreground mode with
    /usr/sbin/php-fpm -F -R
    
#### Cron
Cronie started with:
    cron -n

### Logs
Supervisor logs can be found in
    /var/log/supervisord/supervisord.log
    
### Security
Supervisord admin is listening on TCP:9010, the config file **NOT CONTAINS** the password for the admin GUI!

## Additional features
    ./os15-php74-xxx/

os15-php74-xxx images based on os15-php74-base image, but with special arguments to ensure the ability to build the proper image with required features only.

Docker build arguments are:
- with_xdebug=TRUE|FALSE
- with_composer=TRUE|FALSE
- with_oci8=TRUE|FALSE
- with_pgsql=TRUE|FALSE
- with_sqlsrv=TRUE|FALSE

Example, build a base image with oci8 driver and xDebug enabled:

    docker build \
    --build-arg with_xdebug=TRUE \
    --build-arg with_composer=FALSE \
    --build-arg with_oci8=TRUE \
    --build-arg with_pgsql=FALSE \
    --build-arg with_sqlsrv=FALSE \
    . \

### Oracle
    --build-arg with_oci8=TRUE
- ORACLE Instantclient 19.8 Base and SDK
- PHP 7.4 PDO
- PEAR MDB2#oci8 beta
    
### PostgreSQL
    --build-arg with_pgsql=TRUE
- PostgreSQL 12 client
- PHP 7.4 PDO
- PEAR MDB2#pgsql beta

### Microsoft SQL Server
    --build-arg with_sqlsrv=TRUE
- Microsoft SQL server client
- PHP 7.4 PDO (5.10.1 - last compatible version)
- PEAR MDB2#sqlsrv beta

### xDebug
    --build-arg with_xDebug=TRUE
- PHP 7.4 xDebug extension

### Composer
    --build-arg with_composer=TRUE
- PHP 7.4 composer

## Build scripts
Found in ./build-scripts/

Build scripts are bash shell scripts, which builds images with :latest tag.  

### Build all base image
    ./build_all.sh
    
    ex: ./build_all.sh 1.0
    the following images will be created:
    os15-php74-base:1.0 os15-php74-base:latest
    ...
    
Builds base and additional images including dev and dev-debug. The following images will be created:

- os15-php74-base
- os15-php74-dev
- os15-php74-dev-debug
- os15-php74-nodb
- os15-php74-pgsql
- os15-php74-sqlsrv
- os15-php74-oci8

### Build all production base image
    ./build_all_prod.sh
Builds database related images:
- os15-php74-nodb
- os15-php74-pgsql
- os15-php74-sqlsrv
- os15-php74-oci8

with the following features:
- OPCache enabled
- xDebug not installed
- Composer installed

### Build local development base images
#### Without xDebug
    ./build_base_dev.sh [version-tag]
Images built with:
- all database drivers
- composer installed
- xDebug not installed
- OPCache enabled (should be disabled in the final image, see later)

#### With xDebug
    ./build_base_dev_debug.sh

## Local development example
    ./local-dev/
    
### Prerequisites
#### Base image created with

    ./build-scripts/build_base.sh
    
#### Development base image created with

    ./build-scripts/build_base_dev.sh
    
### Configuration build
    ./local-dev/run_local.sh
    
Creating offsite_dev image from os15-php74-base-dev
    
1 - Setting volumes to be mounted to host filesystem

2 - Adding extra config files
    - disabling opcache by adding (ZZZ_ prefix is for ensure it is loaded after defualt ini-s)


    /etc/php7/conf.d/ZZZ_opcache.ini

3 - Copying local pre-start script to 


    /usr/local/bin/pre_start_local.sh
    
4 - including local pre-start script into the default pre-start script


    RUN printf "\n/usr/local/bin/pre_start_local.sh\n" >> /usr/local/bin/pre_start.sh;  
    
5 - Create and run container with volume mounts, port exposes


    docker run -d \
      -v /Users/baxi/Work:/host \
      -v /Users/baxi/Work/dockerlogs/dev/applications:/var/log/applications \
      -v /Users/baxi/Work/dockerlogs/dev/apache2:/var/log/apache2 \
      -p 10080:80 -p 9010:9010 -p 10443:443 \
      --name offsite_dev \
      --entrypoint /usr/local/bin/start.sh \
      offsite-dev:latest;
      
      
### Local pre-start script

1. Links Apache configuration files to `/etc/apache2/conf.d/` managed on the host system
2. Links Apache virtual host files to `/etc/apache2/vhosts.d/` managed on the host system
3. Some ORACLE configuration
4. Creating a phpinfo page into Apache root directory just for testing
5. Turning off Apache hardening with renaming `/etc/apache2/conf.d/hardening.conf` to hardening.conf-off
6. Ensures working of host system symbolic links with some magic
