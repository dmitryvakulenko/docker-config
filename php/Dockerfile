FROM php:7.1-fpm
ADD ./config/www.conf /usr/local/etc/php-fpm.d/
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libcurl4-openssl-dev \
        libpq-dev \
        libxml2-dev \
        libicu-dev \
	&& docker-php-ext-install pdo pgsql pdo_mysql gd pcntl mcrypt curl xml mbstring soap zip dom intl \
	&& pecl install redis \
	&& pecl install xdebug \
	&& pecl install mongodb \
	&& docker-php-ext-enable redis xdebug mongodb

