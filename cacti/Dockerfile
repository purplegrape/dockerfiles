FROM debian:stretch

RUN apt-get update
RUN apt-get install git apache2 php7.0 php7.0-mysql php7.0-gd php7.0-ldap php7.0-mcrypt php7.0-opcache php7.0-snmp php7.0-xml php7.0-zip rrdtools snmpd -y
RUN rm -rf /var/www/html; git clone https://github.com/Cacti/cacti /var/www/html
RUN cd /var/www/html; mkdir -p cache log rra
RUN cd /var/www/html; chown -R www-data:www-data cache log rra  

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_CONFDIR /etc/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/run/apache2

WORKDIR /var/www/html
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
