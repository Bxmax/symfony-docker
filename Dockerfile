FROM php:7.4-fpm-alpine

RUN apk --update --no-cache add git nano unzip vim yarn bash

# Install netcat
RUN apk add --no-cache netcat-openbsd

# Install zip
RUN apk add --no-cache zip libzip-dev
RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip

# Install pdo_mysql
RUN docker-php-ext-configure pdo_mysql
RUN docker-php-ext-install pdo_mysql

# Install opcache
RUN docker-php-ext-configure opcache
RUN docker-php-ext-install opcache

# Install intl
RUN apk add --no-cache icu-dev
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install symfony as sy
RUN wget https://get.symfony.com/cli/installer -O - | bash && mv /root/.symfony/bin/symfony /usr/local/bin/sy

# Add custom php configuration
COPY ./php.ini /usr/local/etc/php/

WORKDIR /var/www/html/symfony

EXPOSE 9000
