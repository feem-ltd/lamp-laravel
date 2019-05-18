FROM php:7.2-apache

ENV DEBCONF_NOWARNINGS yes

ADD init_laravel.sh /root

RUN apt-get update \
  && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libmcrypt-dev libssh2-1-dev less git unzip telnet wget vim cron supervisor logrotate insserv \
  && docker-php-ext-install pdo_mysql mysqli mbstring gd iconv \
  && a2enmod rewrite \
  && pecl install mcrypt-1.0.1 \
  && pecl install xdebug \
  && pecl install ssh2-alpha \
  && curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer \
  && touch /var/log/xdebug.log \
  && chown www-data:www-data /var/log/xdebug.log

# Mac 向け hddpd の権限と書き込みディレクトリの権限で問題になる場合の対応
RUN usermod -u 1000 www-data \
  && groupmod -g 1000 www-data

RUN sed -ie '$ a * * * * * www-data for i in `seq 0 10 59`;do (sleep ${i}; php /var/www/html/artisan schedule:run >> /dev/null 2>&1) & done;' /etc/crontab

#CMD chown -R www-data:www-data /var/www/html
RUN update-rc.d supervisor defaults
RUN service supervisor start
RUN insserv -d supervisor
