FROM php:7.4.23-apache as development

ENV DEBCONF_NOWARNINGS yes

ARG TZ=Asia/Tokyo
ARG NODE_VERSION=12.x

ADD build/laravel/init_laravel.sh /root

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
# PHP_INI_DIR ⇒ /usr/local/etc/php 
# RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# COPY build/laravel/conf.d/my-php.ini /usr/local/etc/php/conf.d/my-php.ini
RUN sed -ri -e 's!.*memory_limit =.*!memory_limit = 2048M!g' $PHP_INI_DIR/php.ini
RUN sed -ri -e 's!.*max_execution_time =.*!max_execution_time = 480!g' $PHP_INI_DIR/php.ini
RUN sed -ri -e 's!.*date.timezone =.*!date.timezone = "Asia/Tokyo"!g' $PHP_INI_DIR/php.ini
RUN sed -ri -e 's!.*mbstring.internal_encoding =.*!mbstring.internal_encoding = "UTF-8"!g' $PHP_INI_DIR/php.ini
RUN sed -ri -e 's!.*mbstring.language =.*!mbstring.language = "Japanese"!g' $PHP_INI_DIR/php.ini


###########################################################
# モジュールのインストール
###########################################################
RUN set -xe; \
  apt-get update -yqq && \
  apt-get install -yqq --no-install-recommends \
  apt-utils gettext git less vim \
  default-mysql-client \
  # for gd
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libwebp-dev \
  libxpm-dev \
  # for ImageMagick
  libmagickwand-dev \
  # for zip
  libzip-dev zip unzip \
  # for oniguruma
  libonig-dev \
  && docker-php-ext-install bcmath gettext mbstring mysqli pdo pdo_mysql zip \
  && docker-php-ext-configure mbstring --disable-mbregex \
  # && docker-php-ext-configure zip --with-libzip \
  # gd
  && docker-php-ext-install -j$(nproc) iconv \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) gd \
  # imagick
  && pecl install imagick \
  && docker-php-ext-enable imagick \
  # exif
  && docker-php-ext-install exif \
  && docker-php-ext-enable exif \
  # enable mod_rewrite
  && a2enmod rewrite \
  # enable ssl
  # && a2enmod ssl \
  # enable site
  # && a2ensite default-ssl \
  # for ssl
  && apt-get update \
  && apt-get -y install ngrep \
  # && openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=JP/CN=localhost" \
  # -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt \
  # set timezone
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
  # node
  && curl -sL https://deb.nodesource.com/setup_$NODE_VERSION | bash - \
  && apt-get install -y nodejs-legacy \
  && npm i yarn -g \
  # install composer
  && cd '/' \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin

# laravel installer
RUN composer global require "laravel/installer" \
  && composer global require "laravel/envoy"

WORKDIR /var/www/html
#CMD chown -R www-data:www-data /var/www/html
#RUN update-rc.d supervisor defaults
#RUN service supervisor start
#RUN insserv -d supervisor


FROM development as production

COPY volumes/laravel /var/www/html

RUN cp .env.example .env

RUN sed -ri -e 's!APP_ENV=.*!APP_ENV=production!g' /var/www/html/.env
RUN sed -ri -e 's!APP_DEBUG=.*!APP_DEBUG=false!g' /var/www/html/.env

RUN composer install && \
  # php artisan key:generate && \
  yarn install && \
  chmod -R 777 storage && \
  yarn run prod
