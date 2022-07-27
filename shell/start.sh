#!/bin/sh

if [ ! -f /etc/nginx/conf.d/.docker-inited ]; then 
  cp /docker-entrypoint.d/conf.d/default.conf /etc/nginx/conf.d/
  touch /etc/nginx/conf.d/.docker-inited
fi
if [ ! -f /var/www/.docker-inited ]; then 
  cp /docker-entrypoint.d/www/index.php /var/www/index.php
  touch /var/www/.docker-inited
fi
nohup /usr/sbin/php-fpm8 &
nginx -g "daemon off;"