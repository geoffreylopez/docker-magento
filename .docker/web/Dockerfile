FROM php:8.4-fpm

# Installer dépendances système nécessaires à Magento
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    libsodium-dev \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install \
        bcmath \
        intl \
        pdo_mysql \
        soap \
        xsl \
        zip \
        gd \
        sodium \
        opcache \
        ftp \
        sockets \
    && rm -rf /var/lib/apt/lists/*

# Installer Composer globalement
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm composer-setup.php

# Configurer opcache (fortement recommandé pour Magento)
RUN { \
    echo 'opcache.enable=1'; \
    echo 'opcache.enable_cli=1'; \
    echo 'opcache.memory_consumption=512'; \
    echo 'opcache.max_accelerated_files=100000'; \
    echo 'opcache.validate_timestamps=0'; \
} > /usr/local/etc/php/conf.d/opcache.ini

# Installer redis-cli
RUN apt-get update && apt-get install -y redis-tools

# Installer Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && { \
        echo 'zend_extension=xdebug.so'; \
        echo 'xdebug.mode=debug'; \
        echo 'xdebug.start_with_request=yes'; \
        echo 'xdebug.client_host=host.docker.internal'; \
        echo 'xdebug.client_port=9003'; \
        echo 'xdebug.log_level=0'; \
    } > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD []

