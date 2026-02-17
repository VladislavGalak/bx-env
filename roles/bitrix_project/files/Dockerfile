FROM php:8.2-fpm-bullseye

ARG DEBIAN_FRONTEND=noninteractive

# Установка системных зависимостей
RUN apt-get update && apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libxpm-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libonig-dev \
    libldap2-dev \
    libmemcached-dev \
    zlib1g-dev \
    libbz2-dev \
    libssl-dev \
    msmtp \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Настройка и установка PHP-расширений для Bitrix
RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
        --with-xpm \
    && docker-php-ext-install -j$(nproc) \
        gd \
        mysqli \
        pdo \
        pdo_mysql \
        opcache \
        zip \
        intl \
        xml \
        soap \
        mbstring \
        curl \
        fileinfo \
        bz2 \
        ldap \
        exif \
        bcmath \
        sockets

# Установка memcached через PECL
RUN pecl install memcached \
    && docker-php-ext-enable memcached

# Установка Redis через PECL
RUN pecl install redis \
    && docker-php-ext-enable redis

# Установка Xdebug (опционально, для разработки)
# RUN pecl install xdebug && docker-php-ext-enable xdebug

# Установка Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Копирование кастомного php.ini
COPY php.ini /usr/local/etc/php/conf.d/90-bitrix.ini

# Настройка прав для www-data
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]

