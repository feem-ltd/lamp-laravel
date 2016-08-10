FROM php:5.6-apache

RUN apt-get update \
  && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libmcrypt-dev less \
  && docker-php-ext-install pdo_mysql mysqli mbstring gd iconv mcrypt \
  && a2enmod rewrite \
  && curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer
