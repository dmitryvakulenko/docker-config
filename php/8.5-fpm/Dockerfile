FROM php:8.5-fpm-alpine3.23

ARG XDEBUG_VERSION=3.5.0
ARG HTTP_PROXY=http://localhost:2080
ARG HTTPS_PROXY=http://localhost:2080

RUN apk --no-cache add -q \
        git \
        libpng \
        libjpeg-turbo \
        libpq \
        icu-libs \
        openssh \
        imap \
        c-client \
        libzip \
        libintl \
        icu-data-full \
        libldap \
        tzdata \
    && apk --no-cache add --virtual build-dependencies -q \
        autoconf \
        make \
        gcc \
        g++ \
        musl-dev \
        linux-headers \
        postgresql-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        libxml2-dev \
        icu-dev \
        gettext-dev \
        openldap-dev \
        imap-dev \
        libzip-dev \
        krb5-dev \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
    && echo "Europe/Moscow" > /etc/timezone \
    && docker-php-ext-install \
        pdo_pgsql \
        pgsql \
        gd \
        pcntl \
        soap \
        zip \
        intl \
        bcmath \
        gettext \
        ldap \
        exif \
        sockets \
    && yes '' | pecl install redis mongodb xdebug-${XDEBUG_VERSION} imap apcu protobuf \
    && docker-php-ext-enable redis mongodb xdebug imap apcu protobuf \
    && rm -rf /tmp/pear \
    && apk del --purge build-dependencies \
    && apk --no-cache add curl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chown -R www-data:www-data /usr/local/bin/composer \
    && mkdir -p /home/www-data/.composer \
    && chown -R www-data:www-data /home/www-data/.composer

ENV SSH_AUTH_SOCK=/root/ssh.pid

RUN rm -rf /usr/local/etc/php-fpm.d/*
COPY www.conf /usr/local/etc/php-fpm.d/

COPY php.ini /usr/local/etc/php/
COPY start-php /usr/local/bin
RUN chmod a+x /usr/local/bin/start-php

EXPOSE 9000
ENTRYPOINT ["start-php"]
CMD ["php-fpm"]