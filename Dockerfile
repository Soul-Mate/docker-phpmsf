FROM php:7.1
RUN apt-get update
RUN apt-get install -y curl git gcc gdb libmemcached-dev zlib1g-dev imagemagick mongodb
RUN pecl install yac-2.0.2 && \
		pecl install redis-3.1.6 && \
		pecl install swoole-1.10.4 && \
		pecl install xdebug && \
		pecl install memcached && \
		pecl install igbinary && \
		pecl install inotify && \
		pecl install mongodb && \
		docker-php-ext-enable yac redis swoole xdebug igbinary inotify mongodb

# install composer
RUN curl -s https://getcomposer.org/installer | php && \
		chmod a+x composer.phar && \
		mv composer.phar /usr/local/bin/composer && \
		composer config -g repo.packagist composer https://packagist.phpcomposer.com
COPY run.sh /run.sh
RUN chmod u+x /*.sh
CMD ["/run.sh"]
