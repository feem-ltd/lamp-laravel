FROM php:7.4.18-fpm-alpine3.13

ENV TZ=UTC \
  # locale
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8 \
  # composer environment
  COMPOSER_ALLOW_SUPERUSER=1 \
  COMPOSER_HOME=/composer \
  # Laravel environment
  DB_CONNECTION=mysql \
  DB_HOST=db \
  DB_DATABASE=laravel_local \
  DB_USERNAME=phper \
  DB_PASSWORD=secret

# COPY init_laravel.sh /root
# シェルスクリプトが LF でないと実行されないので、念のため LF に変換をおこなう。
# RUN sed -i 's/\r//' /root/init_laravel.sh

COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

###########################################################
# PHP の設定
###########################################################
# RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
# RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY build/laravel/conf.d/my-php.ini /usr/local/etc/php/conf.d/my-php.ini


###########################################################
# モジュールのインストール
###########################################################
# ssh2.so のインストール方法
# 参考：https://stackoverflow.com/questions/49886490/ssh2-for-php7-macos

RUN apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add \
  autoconf \
  bash \
  curl-dev \
  freetype-dev \
  g++ \
  git \
  libjpeg-turbo-dev \
  libpng-dev \
  libxml2-dev \
  libzip-dev \
  make \
  nodejs-npm \
  oniguruma-dev \
  openssl \
  pcre-dev \
  tzdata \
  vim \
  zlib-dev \
  && docker-php-ext-install \
  curl \
  dom \
  mbstring \
  pdo \
  pdo_mysql \
  simplexml \
  zip \
  opcache \
  && docker-php-ext-configure gd \
  --with-freetype=/usr/include/ \
  --with-jpeg=/usr/include/ \
  && docker-php-ext-install gd
# rm -rf /var/lib/apt/lists/* && \
# locale-gen en_US.UTF-8 && \
# localedef -f UTF-8 -i en_US en_US.UTF-8 && \
RUN mkdir /var/run/php-fpm && \
  mkdir /var/log/php && \
  # && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  # && chmod +x /usr/local/bin/composer \
  # rm -rf /var/cache/apk/* && \
  composer config -g process-timeout 3600 && \
  composer config -g repos.packagist composer https://packagist.jp

RUN npm i yarn -g
