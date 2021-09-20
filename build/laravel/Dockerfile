FROM php:7.4.23-apache

ENV DEBCONF_NOWARNINGS yes

ADD init_laravel.sh /root

# シェルスクリプトが LF でないと実行されないので、念のため LF に変換をおこなう。
RUN sed -i 's/\r//' /root/init_laravel.sh

# COPY ./php.ini /usr/local/etc/php/
# COPY ./conf.d/*.conf /etc/apache2/sites-enabled/

###########################################################
# Apache の設定
###########################################################
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf


###########################################################
# PHP の設定
###########################################################
# RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY ./my-php.ini /usr/local/etc/php/conf.d/my-php.ini


###########################################################
# モジュールのインストール
###########################################################
# docker-php-ext-install で zip をインストールするためには、zlib1g-dev が必要。
RUN apt-get update \
  && apt-get install -y \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libmcrypt-dev \
  libssh2-1-dev \
  libonig-dev \
  libzip-dev \
  zlib1g-dev \
  less git unzip telnet wget vim cron supervisor logrotate insserv gnupg \
  && docker-php-ext-install pdo_mysql mysqli gd iconv zip \
  && a2enmod rewrite \
  # && pecl install mcrypt-1.0.1 \
  && pecl install xdebug \
  # 下記のように指定すると、2019/11/07 現在、pecl のサイトで 500 エラーになるので、バージョンを指定するようにした。
  # && pecl install ssh2-alpha \
  # && pecl install channel://pecl.php.net/ssh2-1.1.2 \
  && curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer \
  && touch /var/log/xdebug.log \
  && chown www-data:www-data /var/log/xdebug.log
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y nodejs
RUN npm install -g n \
  && n lts

# Mac 向け hddpd の権限と書き込みディレクトリの権限で問題になる場合の対応
RUN usermod -u 1000 www-data \
  && groupmod -g 1000 www-data

RUN sed -ie '$ a * * * * * www-data for i in `seq 0 10 59`;do (sleep ${i}; php /var/www/html/artisan schedule:run >> /dev/null 2>&1) & done;' /etc/crontab

#CMD chown -R www-data:www-data /var/www/html
#RUN update-rc.d supervisor defaults
#RUN service supervisor start
#RUN insserv -d supervisor
