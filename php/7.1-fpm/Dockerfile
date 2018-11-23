FROM php:7.1-fpm-alpine

MAINTAINER Dmitry Vakulenko

COPY ssl.patch /tmp/ssl.patch
RUN apk --no-cache add -q git libpng libjpeg libpq libintl icu-libs openssh libmcrypt \
    && apk --no-cache add --virtual build-dependencies -q postgresql-dev libpng-dev libjpeg-turbo-dev curl-dev libxml2-dev icu-dev gettext-dev php7-dev libmcrypt-dev musl-dev make gcc tzdata ldap-dev \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone \
    && docker-php-ext-install pdo pdo_pgsql gd pcntl curl xml mbstring soap zip dom intl bcmath gettext mcrypt ldap \
    && pecl install redis xdebug \
    && cd /tmp; pecl download mongodb && tar xvzf mongodb-1.5.2.tgz && cd mongodb-1.5.2/src/libmongoc && patch -p1 < /tmp/ssl.patch \
    && cd  ../../ && phpize && ./configure && make && make install \
    && docker-php-ext-enable redis xdebug mongodb mcrypt ldap \
    && rm /tmp/ssl.patch && rm /tmp/mongodb-1.5.2.tgz && rm -R /tmp/mongodb-1.5.2 && rm -R /tmp/pear \
    && apk del --purge -r build-dependencies \
    # composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chown -R www-data:www-data /usr/local/bin/composer \
    && mkdir -p /home/www-data/.composer \
    && chown -R www-data:www-data /home/www-data/.composer

COPY www.conf /usr/local/etc/php-fpm.d/
COPY php.ini /usr/local/etc/php/
COPY start-php /usr/local/bin
RUN chmod a+x /usr/local/bin/start-php

EXPOSE 9000
ENTRYPOINT ["start-php"]
CMD ["php-fpm"]