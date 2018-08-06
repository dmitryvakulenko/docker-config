FROM php:7.1-fpm-alpine

MAINTAINER Dmitry Vakulenko

RUN apk update \
    && apk add -q postgresql-dev libpng-dev libjpeg-turbo-dev curl-dev libxml2-dev icu-dev gettext-dev php7-dev libmcrypt-dev libc-dev make gcc git \
    && docker-php-ext-install pdo pdo_pgsql gd pcntl curl xml mbstring soap zip dom intl bcmath gettext \
    && pecl install redis xdebug mongodb mcrypt-1.0.1 \
    && docker-php-ext-enable redis xdebug mongodb \
    && apk del -q postgresql-dev libpng-dev libjpeg-turbo-dev curl-dev libxml2-dev icu-dev gettext-dev php7-dev libmcrypt-dev make gcc libc-dev \
    && apk add libpng libjpeg libpq libintl icu-libs openssh \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chown -R www-data:www-data /usr/local/bin/composer \
    && mkdir -p /var/www/.composer \
    && chown -R www-data:www-data /var/www/.composer

COPY www.conf /usr/local/etc/php-fpm.d/
COPY php.ini /usr/local/etc/php/
COPY start-php /usr/local/bin
RUN chmod a+x /usr/local/bin/start-php

EXPOSE 9000
ENTRYPOINT ["start-php"]
CMD ["php-fpm"]