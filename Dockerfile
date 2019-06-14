FROM php:7.3.6-fpm-stretch

RUN docker-php-ext-install pdo pdo_mysql \
        && usermod -u 1000 www-data

WORKDIR /var/www

RUN rm -rf /var/www/html \
        && ln -s public html \
        &&curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


EXPOSE 9000
ENTRYPOINT ["php-fpm"]
