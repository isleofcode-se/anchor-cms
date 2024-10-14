FROM php:8.2.0-apache

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql

# Install Composer globally.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# RUN apk update && apk upgrade && \
#     apk add bash wget curl apache2
# RUN apk add php php83-pdo_mysql
# RUN docker-php-ext-install gd 
# RUN apk add apache2 php83-apache2
# RUN apk add composer
# # RUN apk add php7-mbstring php7-mcrypt
# # RUN    php7-apache2 php7-openssl php7-curl php7-json
# # RUN    php7-pdo php7-pdo_mysql php7-gd
# # RUN    php7-intl php7-opcache php7-session

# RUN sed -i "s|display_errors = Off|display_errors = On|" /etc/php83/php.ini
# RUN sed -i "s|variables_order = .*|variables_order = EGPCS|" /etc/php83/php.ini
# RUN sed -i "s|;cgi.fix_pathinfo=1|cgi.fix_pathinfo=0|" /etc/php83/php.ini
# RUN sed -i "s|#LoadModule rewrite_module modules/mod_rewrite.so|LoadModule rewrite_module modules/mod_rewrite.so|" /etc/apache2/httpd.conf
# RUN sed -i 's#^DocumentRoot ".*#DocumentRoot "/var/www/html"#g' /etc/apache2/httpd.conf
# RUN echo '<Directory "/var/www/html/">' >> /etc/apache2/httpd.conf
# RUN echo 'Require all granted' >> /etc/apache2/httpd.conf
# RUN echo 'AllowOverride FileInfo' >> /etc/apache2/httpd.conf
# RUN echo '</Directory>' >> /etc/apache2/httpd.conf
# RUN echo 'HttpProtocolOptions "Unsafe"' >> /etc/apache2/httpd.conf
# RUN mkdir /run/apache2/
# RUN ln -sf /dev/null /var/log/apache2/access.log
# RUN ln -sf /dev/stderr /var/log/apache2/error.log

# RUN rm -rf /var/cache/apk/*

WORKDIR /var/www/html
VOLUME ["/var/www/html"]

EXPOSE 80

CMD ["apache2-foreground"]
