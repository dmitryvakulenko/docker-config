FROM php:7.1-fpm-alpine

MAINTAINER Dmitry Vakulenko

RUN apk --no-cache add -q git libpng libjpeg libpq libintl icu-libs openssh libmcrypt imap c-client \
    && apk --no-cache add --virtual build-dependencies -q autoconf postgresql-dev libpng-dev libjpeg-turbo-dev curl-dev libxml2-dev icu-dev gettext-dev php7-dev libmcrypt-dev musl-dev make gcc tzdata openldap-dev imap-dev \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone \
    && docker-php-ext-install pdo pdo_pgsql gd pcntl curl xml mbstring soap zip dom intl bcmath gettext mcrypt ldap imap \
    && pecl install redis xdebug \
    && cd /tmp; pecl download mongodb && tar xzf mongodb-1.5.3.tgz && cd mongodb-1.5.3/src/libmongoc \
    && cd  ../../ && phpize && ./configure && make && make install \
    && docker-php-ext-enable redis xdebug mongodb \
    && rm /tmp/mongodb-1.5.3.tgz && rm -R /tmp/mongodb-1.5.3 && rm -R /tmp/pear \
    && apk del --purge -r build-dependencies \
    # composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chown -R www-data:www-data /usr/local/bin/composer \
    && mkdir -p /home/www-data/.composer \
    && chown -R www-data:www-data /home/www-data/.composer

ENV SSH_AUTH_SOCK=/root/ssh.pid
COPY www.conf /usr/local/etc/php-fpm.d/
COPY php.ini /usr/local/etc/php/
COPY start-php /usr/local/bin
RUN chmod a+x /usr/local/bin/start-php

EXPOSE 9000
ENTRYPOINT ["start-php"]
CMD ["php-fpm"]