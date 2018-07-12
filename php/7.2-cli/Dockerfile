FROM php:7.2-cli

MAINTAINER Dmitry Vakulenko

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libcurl4-openssl-dev \
        libpq-dev \
        libxml2-dev \
        libicu-dev \
        git \
	&& docker-php-ext-install pdo pdo_pgsql gd pcntl curl xml mbstring soap zip dom intl bcmath gettext \
	&& pecl install redis \
	&& pecl install xdebug \
	&& pecl install mongodb \
	&& pecl install mcrypt-1.0.1 \
	&& docker-php-ext-enable redis xdebug mongodb

RUN apt-get autoclean

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN chown -R www-data:www-data /usr/local/bin/composer

RUN mkdir -p /var/www/.composer
RUN chown -R www-data:www-data /var/www/.composer

ADD php.ini /usr/local/etc/php/

ADD start-php /usr/local/bin
RUN chmod a+x /usr/local/bin/start-php

EXPOSE 9000
ENTRYPOINT ["start-php"]
CMD ["php", "-a"]