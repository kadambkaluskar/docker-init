FROM php:7.0-fpm
RUN apt-get update && apt-get install -y \
     apt-utils \
     libssl-dev \
     libfreetype6-dev \
     libjpeg62-turbo-dev \
     libmcrypt-dev \
     libpng-dev \
     && docker-php-ext-install -j$(nproc) iconv mcrypt \
     && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
     && docker-php-ext-install -j$(nproc) gd

RUN apt-get update 
RUN apt-get install -y libmemcached-dev 
RUN pecl install memcached 
RUN docker-php-ext-enable memcached

RUN pecl install apcu
RUN docker-php-ext-enable apcu

#RUN pecl install apcu-bc
RUN pecl install apcu_bc-1.0.3
RUN docker-php-ext-enable apc

#docker-php-ext-apc.ini
RUN mv /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini /usr/local/etc/php/conf.d/1docker-php-ext-apcu.ini
RUN mv /usr/local/etc/php/conf.d/docker-php-ext-apc.ini /usr/local/etc/php/conf.d/2docker-php-ext-apc.ini

RUN docker-php-ext-install bcmath
RUN docker-php-ext-enable bcmath

RUN apt-get install -y openssl
RUN apt-get install -y curl libcurl4-openssl-dev

#RUN mkdir /usr/src/php   
#RUN mkdir /usr/src/php/ext
#RUN curl https://pecl.php.net/get/mongo-1.5.8.tgz > /tmp/mongo.tgz
#RUN tar -xpzf /tmp/mongo.tgz -C /tmp
#RUN mv /tmp/mongo-1.5.8 /usr/src/php/ext
#RUN docker-php-ext-install mongo-1.6

RUN pecl install mongodb && docker-php-ext-enable mongodb




RUN apt-get install -y libpng-dev
RUN apt-get install -y libjpeg-dev
RUN docker-php-ext-install gd
RUN docker-php-ext-enable gd

RUN apt-get install -y libxml2-dev
RUN docker-php-ext-install dom

RUN docker-php-ext-install soap
RUN docker-php-ext-enable soap

RUN docker-php-ext-install mysqli
RUN docker-php-ext-enable mysqli
#RUN apt-get install php-mysql

RUN docker-php-ext-install mbstring
RUN docker-php-ext-enable mbstring

RUN docker-php-ext-install curl
RUN docker-php-ext-enable curl

RUN apt-get install -y libc-client-dev
RUN apt-get install -y libkrb5-dev
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install -j$(nproc) imap

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-enable pdo_mysql

RUN apt-get install -y wget
RUN wget https://phar.phpunit.de/phpunit.phar
RUN chmod +x phpunit.phar
RUN mv phpunit.phar /usr/local/bin/phpunit

RUN mkdir /home/vtermina
RUN mkdir /home/kadamb/public_html
RUN chmod -R 777 /home/kadamb/*

RUN apt-get install -y procps
RUN apt-get install -y nginx
COPY vhost.conf /etc/nginx/sites-enabled/vhost.conf
EXPOSE 80
EXPOSE 443
#CMD ["/usr/sbin/nginx"]
RUN chmod -R 777 /home
RUN chmod -R 777 /home/*
#CMD service nginx restart
#ENTRYPOINT ["service","nginx","restart"]

RUN apt-get install -y redis-server
