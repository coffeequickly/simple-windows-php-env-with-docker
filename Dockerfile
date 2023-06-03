FROM php:7.4-apache
RUN apt-get update
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install mysqli gd
RUN docker-php-ext-enable gd

COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html
