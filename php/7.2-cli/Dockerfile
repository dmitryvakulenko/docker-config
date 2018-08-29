FROM php:7.2-cli-alpine

MAINTAINER Dmitry Vakulenko

COPY ssl.patch /tmp/ssl.patch
RUN apk --no-cache add -q git libpng libjpeg libpq libintl icu-libs openssh \
    && apk --no-cache add --virtual build-dependencies -q postgresql-dev libpng-dev libjpeg-turbo-dev curl-dev libxml2-dev icu-dev gettext-dev php7-dev libmcrypt-dev musl-dev make gcc tzdata \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone \
    && docker-php-ext-install pdo pdo_pgsql gd pcntl curl xml mbstring soap zip dom intl bcmath gettext \
    && pecl install redis xdebug mcrypt-1.0.1 \
    && cd /tmp; pecl download mongodb && tar xvzf mongodb-1.5.2.tgz && cd mongodb-1.5.2/src/libmongoc && patch -p1 < /tmp/ssl.patch \
    && cd  ../../ && phpize && ./configure && make && make install \
    && docker-php-ext-enable redis xdebug mongodb \
    && rm /tmp/ssl.patch \
    && apk del --purge -r build-dependencies \
    # composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chown -R www-data:www-data /usr/local/bin/composer \
    && mkdir -p /var/www/.composer \
    && chown -R www-data:www-data /var/www/.composer

COPY php.ini /usr/local/etc/php/
COPY start-php /usr/local/bin
RUN chmod a+x /usr/local/bin/start-php

ENTRYPOINT ["start-php"]
CMD ["php", "-a"]