FROM opensuse/tumbleweed:latest

# https://software.opensuse.org/explore

#zypper --non-interactive --gpg-auto-import-keys \
 #          addrepo "https://download.opensuse.org/repositories/devel:languages:php/openSUSE_Leap_15.5/devel:languages:php.repo"; \

# php8
RUN zypper --non-interactive --gpg-auto-import-keys refresh; \
    zypper --non-interactive --gpg-auto-import-keys install \
      awk \
      apache2 \
      cronie \
      curl \
      supervisor \
      nano \
      telnet \
      gzip \
      zip \
      unzip \
      tar \
      git \
      subversion \
      php8 \
      php8-fpm \
      php8-openssl \
      php8-gd \
      php8-bcmath \
      php8-mbstring \
      php8-zip \
      php8-phar \
      php8-zlib \
      php8-fileinfo \
      php8-curl \
      php8-pcntl \
      php8-ctype \
      php8-dom \
      php8-iconv \
      php8-xmlreader \
      php8-xmlwriter \
      php8-opcache \
      php8-pear \
      php8-soap \
      php8-exif \
      php8-redis; \
    pear channel-update pear.php.net; \
    pear install Mail Mail_Mime Net_SMTP; \
    mkdir -p /var/log/fpm; \
    chown wwwrun:www /var/log/fpm; \
    mkdir -p /var/log/apache2; \
    chown wwwrun:www /var/log/apache2; \
    zypper --non-interactive clean -a; \
    rm -rf /tmp/*;

COPY etc/php8/fpm/php-fpm.d/default.conf /etc/php8/fpm/php-fpm.d/default.conf
COPY etc/apache2/conf.d/*.conf /etc/apache2/conf.d/
COPY etc/php8/conf.d/*.ini /etc/php8/conf.d/
COPY etc/apache2/loadmodule.conf /tmp/loadmodule.conf
COPY etc/supervisor.conf /etc/supervisor.conf

RUN cat /tmp/loadmodule.conf >> /etc/apache2/loadmodule.conf;

# start scripts
COPY scripts/*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

EXPOSE 80 443 9010
