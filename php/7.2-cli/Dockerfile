FROM php:7.2-cli-alpine3.9

MAINTAINER Dmitry Vakulenko

RUN apk --no-cache add -q git libpng libjpeg libpq libintl icu-libs openssh libmcrypt libzip \
    && apk --no-cache add --virtual build-dependencies -q postgresql-dev libpng-dev libjpeg-turbo-dev curl-dev libxml2-dev icu-dev gettext-dev php7-dev libmcrypt-dev musl-dev make gcc tzdata libzip-dev \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone \
    && docker-php-ext-install pdo pdo_pgsql gd pcntl curl xml mbstring soap zip dom intl bcmath gettext \
    && yes '' | pecl install redis xdebug mcrypt-1.0.2 mongodb \
    # ext-ssh2
    && cd /tmp; wget https://www.libssh2.org/download/libssh2-1.9.0.tar.gz && tar -xf libssh2-1.9.0.tar.gz
    &&
    && git clone https://github.com/krakjoe/pthreads -b master /tmp/pthreads \
    && docker-php-ext-configure /tmp/pthreads --enable-pthreads \
    && docker-php-ext-install /tmp/pthreads \
    && docker-php-ext-enable redis xdebug mongodb mcrypt mongodb \
    && rm -R /tmp/pthreads \
    && apk del --purge -r build-dependencies \
    # composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chown -R www-data:www-data /usr/local/bin/composer \
    && mkdir -p /home/www-data/.composer \
    && chown -R www-data:www-data /home/www-data/.composer

ENV SSH_AUTH_SOCK=/root/ssh.pid
COPY php.ini /usr/local/etc/php/
COPY start-php /usr/local/bin
RUN chmod a+x /usr/local/bin/start-php

ENTRYPOINT ["start-php"]
CMD ["php", "-a"]
