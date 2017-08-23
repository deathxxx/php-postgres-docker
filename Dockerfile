FROM ubuntu:16.04
MAINTAINER Dex

VOLUME ["/var/www"]

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y \
      apache2 \
      php7.0 \
      php7.0-cli \
      libapache2-mod-php7.0 \
      php7.0-gd \
      php7.0-json \
      php7.0-ldap \
      php7.0-mbstring \
      php7.0-mysql \
      php7.0-pgsql \
      php7.0-sqlite3 \
      php7.0-xml \
      php7.0-xsl \
      php7.0-zip \
      php7.0-soap \
      php-xdebug \
      php7.0-dev \
      net-tools \
      mc \
      telnetd

# Install developer dependencies
#RUN apt-get update -yqq && \
#    apt-get install -y \
#        git \
#        libsqlite3-dev \
#        libxml2-dev \
#        libicu-dev \
#        libfreetype6-dev \
#        libmcrypt-dev \
#        libjpeg62-turbo-dev \
#        libpng12-dev \
#        libcurl4-gnutls-dev \
#        libbz2-dev \
#        libssl-dev -yqq

COPY docker-conf/apache_default /etc/apache2/sites-available/000-default.conf
COPY docker-conf/run /usr/local/bin/run
COPY docker-conf/php.ini /etc/php/7.0/apache2/php.ini
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

# Set the timezone.
RUN echo "Asia/Bishkek" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
#RUN apt-get install --reinstall tzdata

EXPOSE 80
CMD ["/usr/local/bin/run"]
