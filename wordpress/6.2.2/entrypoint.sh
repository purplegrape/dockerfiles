#!/usr/bin/env bash

set -e -x

if [ ! -d /data/wordpress ];then
  unzip -q -n -d /data /wordpress-6.2.2.zip
  chown -R www-data.www-data /data/wordpress/wp-content
fi

/usr/sbin/apache2ctl -M
/usr/bin/php -m

exec $@