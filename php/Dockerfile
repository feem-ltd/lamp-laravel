FROM php:7.1.6-apache

RUN apt-get update \
  && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libmcrypt-dev less git unzip telnet wget vim supervisor \
  && docker-php-ext-install pdo_mysql mysqli mbstring gd iconv mcrypt \
  && a2enmod rewrite \
  && pecl install xdebug \
  && curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer \
  && touch /var/log/xdebug.log \
  && chown www-data:www-data /var/log/xdebug.log
# Mac 向け hddpd の権限と書き込みディレクトリの権限で問題になる場合の対応
RUN usermod -u 1000 www-data \
  && groupmod -g 1000 www-data

#CMD chown -R www-data:www-data /var/www/html
RUN update-rc.d supervisor defaults
RUN service supervisor start
