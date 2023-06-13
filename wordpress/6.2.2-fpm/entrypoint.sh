#!/usr/bin/env bash

set -e -x

if [ ! -d /data/wordpress ];then
  unzip -q -n -d /data /usr/src/wordpress-6.2.2.zip
  chown -R www-data.www-data /data/wordpress/wp-content
  ln -sf /data/wordpress /var/www/html
fi

/usr/bin/php -m

exec $@