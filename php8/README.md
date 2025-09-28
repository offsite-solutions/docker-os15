# Offsite Solutions :: Base docker images

## Base image
Base image is based on OpenSUSE Tumbleweed (20250928), with the following features:

### System apps
- Apache v2.4.65
- Cronie v1.7.2
- Supervisord v4.2.5
- Network
    - curl
    - telnet
- Runtime editing - debugging
    - Nano
- Archive
    - zip
    - unzip
    - tar
- Versioning
    - git
    - svn  
  
### PHP 8.4
- FPM
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

### PHP 8.4
    The actual version of PHP 8.4.15 installed with the followings:
    PHP 8.4.12 (cli) (built: Aug 28 2025 15:30:21) (NTS)
    Copyright (c) The PHP Group
    Zend Engine v4.4.12, Copyright (c) Zend Technologies
        with Zend OPcache v8.4.12, Copyright (c), by Zend Technologies
        with Xdebug v3.4.5, Copyright (c) 2002-2025, by Derick Rethans

#### Modules
- fpm
- openssl
- gd
- bcmath
- mbstring
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
- redis
- soap
- exif

#### php.ini
PHP ini settings found in:

    /etc/php8/conf.d/000_php.ini

#### FPM
FPM configured to listen on TCP:9074

    /etc/php8/fpm/php-fpm.d/default.conf

#### OPCache
OPCache is enabled by default

    /etc/php8/conf.d/000_opcache.ini

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
    ./os15-php8-xxx/

os15-php8-xxx images based on os15-php8-base image, but with special arguments to ensure the ability to build the proper image with required features only.

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
- ORACLE Instantclient 21.13 Base and SDK
- PHP OCI v1.1.0
    
### PostgreSQL
    --build-arg with_pgsql=TRUE
- PostgreSQL 17.2.9 client
- PDO v17.6

### Microsoft SQL Server
    --build-arg with_sqlsrv=TRUE
- Microsoft SQL server client v17
- PDO v5.12.0

### xDebug
    --build-arg with_xDebug=TRUE
- xDebug v3.4.5 extension

### Composer
    --build-arg with_composer=TRUE
- Composer v2.8.9

## Build scripts
Found in ./build-scripts/

Build scripts are bash shell scripts, which builds images with :latest tag.  

### Build all base image
    ./build_all.sh
    
    ex: ./build_all.sh 1.0
    the following images will be created:
    os15-php8-base:1.0 os15-php8-base:latest
    ...
    
Builds base and additional images including dev and dev-debug. The following images will be created:

- os15-php8-base
- os15-php8-dev
- os15-php8-dev-debug
- os15-php8-nodb
- os15-php8-pgsql
- os15-php8-sqlsrv
- os15-php8-oci8

### Build all production base image
    ./build_all_prod.sh
Builds database related images:
- os15-php8-nodb
- os15-php8-pgsql
- os15-php8-sqlsrv
- os15-php8-oci8

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
    
Creating offsite_dev image from os15-php8-base-dev
    
1 - Setting volumes to be mounted to host filesystem

2 - Adding extra config files
    - disabling opcache by adding (ZZZ_ prefix is for ensure it is loaded after defualt ini-s)


    /etc/php8/conf.d/ZZZ_opcache.ini

3 - Copying local pre-start script to 


    /usr/local/bin/pre_start_local.sh
    
4 - including local pre-start script into the default pre-start script


    RUN printf "\n/usr/local/bin/pre_start_local.sh\n" >> /usr/local/bin/pre_start.sh;  
    
5 - Create and run container with volume mounts, port exposes


    docker run -d \
      -v /Users/baxi/Work:/host \
      -v /Users/baxi/Work/dockerlogs/dev/applications:/var/log/applications \
      -v /Users/baxi/Work/dockerlogs/dev/apache2:/var/log/apache2 \
      -p 15080:80 -p 9510:9010 -p 15443:443 \
      --name offsite_dev \
      --entrypoint /usr/local/bin/start.sh \
      offsite-dev-php8:latest;
      
      
### Local pre-start script

1. Links Apache configuration files to `/etc/apache2/conf.d/` managed on the host system
2. Links Apache virtual host files to `/etc/apache2/vhosts.d/` managed on the host system
3. Some ORACLE configuration
4. Creating a phpinfo page into Apache root directory just for testing
5. Turning off Apache hardening with renaming `/etc/apache2/conf.d/hardening.conf` to hardening.conf-off
6. Ensures working of host system symbolic links with some magic
