# Use official PHP container with webserver on board
FROM php:7.0-apache

RUN apt-get update && apt-get install -y wget git zip unzip libgd-dev \
    && docker-php-ext-install mysqli pdo_mysql opcache zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Copy required configuration files
COPY 000-default.conf /etc/apache2/sites-available
COPY php.ini /usr/local/etc/php

# Apache settings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && a2enmod rewrite \
    && a2ensite 000-default.conf

# Get composer
#RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
#    && chmod +x /usr/local/bin/composer
#
#RUN composer global require "hirak/prestissimo:^0.3"

ENV DOCKERIZE_VERSION v0.2.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ADD run.sh /opt/run
RUN chmod +x /opt/run

CMD ["/opt/run"]
