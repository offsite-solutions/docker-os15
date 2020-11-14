FROM opensuse/leap:15.2

# https://software.opensuse.org/explore

# php7
RUN zypper --non-interactive --gpg-auto-import-keys \
      addrepo "https://download.opensuse.org/repositories/devel:languages:php/openSUSE_Leap_15.2/devel:languages:php.repo"; \
    zypper --non-interactive --gpg-auto-import-keys refresh; \
    zypper --non-interactive --gpg-auto-import-keys install \
      apache2 \
      cronie \
      curl \
      supervisor \
      nano \
      telnet \
      zip \
      unzip \
      php7 \
      php7-fpm \
      php7-openssl \
      php7-gd \
      php7-bcmath \
      php7-mbstring \
      php7-json \
      php7-zip \
      php7-phar \
      php7-zlib \
      php7-fileinfo \
      php7-curl \
      php7-pcntl \
      php7-ctype \
      php7-dom \
      php7-iconv \
      php7-xmlreader \
      php7-xmlwriter \
      php7-opcache \
      php7-pear \
      php7-redis; \
    pear channel-update pear.php.net; \
    pear install Mail Mail_Mime Net_SMTP; \
    mkdir -p /var/log/fpm; \
    chown wwwrun:www /var/log/fpm; \
    mkdir -p /var/log/apache2; \
    chown wwwrun:www /var/log/apache2; \
    zypper --non-interactive clean -a; \
    rm -rf /tmp/*;

COPY etc/php7/fpm/php-fpm.d/default.conf /etc/php7/fpm/php-fpm.d/default.conf
COPY etc/apache2/conf.d/*.conf /etc/apache2/conf.d/
COPY etc/php7/conf.d/*.ini /etc/php7/conf.d/
COPY etc/apache2/loadmodule.conf /tmp/loadmodule.conf
COPY etc/supervisor.conf /etc/supervisor.conf

RUN cp /etc/php7/fpm/php-fpm.conf.default /etc/php7/fpm/php-fpm.conf; \
    cat /tmp/loadmodule.conf >> /etc/apache2/loadmodule.conf;

# start scripts
COPY scripts/*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

EXPOSE 80 443 9010
