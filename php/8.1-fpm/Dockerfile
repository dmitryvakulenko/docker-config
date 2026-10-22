FROM php:8.1-fpm-alpine3.18

ARG MCRYPT_VERSION=1.0.6
ARG XDEBUG_VERSION=3.2.2
ARG MONGODB_VERSION=1.15.3
ARG GRPC_VERSION=1.57.0

ARG HTTP_PROXY=http://localhost:2081
ARG HTTPS_PROXY=http://localhost:2081

RUN apk --no-cache add -q git libpng libjpeg libpq libintl icu-libs openssh libmcrypt imap c-client imagemagick libzip icu-data-full libgomp libsasl libldap \
    && apk --no-cache add --virtual build-dependencies -q autoconf postgresql-dev libpng-dev libjpeg-turbo-dev curl-dev libxml2-dev icu-dev gettext-dev libmcrypt-dev musl-dev make gcc tzdata openldap-dev imap-dev imagemagick-dev libzip-dev oniguruma-dev postgresql-dev linux-headers g++ \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone \
    && docker-php-ext-install pdo pdo_pgsql pgsql gd pcntl curl xml mbstring soap zip dom intl bcmath gettext ldap imap exif sockets opcache \
    && yes '' | pecl install redis xdebug-${XDEBUG_VERSION} mongodb-${MONGODB_VERSION} imagick mcrypt-${MCRYPT_VERSION} apcu opentelemetry grpc-${GRPC_VERSION} \
    && docker-php-ext-enable redis xdebug mongodb imagick mcrypt apcu opentelemetry grpc \
    && rm -R /tmp/pear \
    && apk del --purge -r build-dependencies \
    # composer
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