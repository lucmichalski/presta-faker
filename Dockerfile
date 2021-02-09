FROM php:7.2-fpm-alpine
Maintainer Michalski Luc <michalski.luc@gmail.com>

RUN apk --no-cache add \
    bash \
    git \
    ca-certificates 

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# RUN git clone --depth=1 https://github.com/lucmichalski/presta-faker /opt/app
COPY . /opt/app
WORKDIR /opt/app

RUN composer install

RUN mkdir -p /opt/app/data/images

VOLUME ["/opt/app"] 

WORKDIR /opt/app/
ENTRYPOINT ["/usr/local/bin/php", "bin/run.php"]
