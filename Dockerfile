FROM php:7.3.6-fpm-stretch

RUN apt-get update \
        && docker-php-ext-install pdo pdo_mysql \
        && usermod -u 1000 www-data \
        && apt-get install -y wget

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /var/www

RUN rm -rf /var/www/html \
        && ln -s public html \
        &&curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


EXPOSE 9000
ENTRYPOINT ["php-fpm"]
