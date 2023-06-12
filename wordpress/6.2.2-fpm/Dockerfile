# syntax=docker/dockerfile:1
FROM docker.io/library/ubuntu:22.04
LABEL org.opencontainers.image.title=wordpress \
      org.opencontainers.image.version=6.2.2 \
      org.opencontainers.image.description="wordpress-6.2.2 & ubuntu-22.04 & php-fpm-8.1.2" \
      org.opencontainers.image.authors="purplegrape4@gmail.com"

RUN sed -i.bak 's/archive.ubuntu.com/cn.archive.ubuntu.com/g' /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update ;\
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y php8.1-cli php8.1-fpm php8.1-opcache php8.1-curl php8.1-gd php8.1-mbstring php8.1-mysql php8.1-msgpack php8.1-xml php8.1-xmlrpc php8.1-uuid php8.1-soap php8.1-redis php8.1-zip tzdata unzip ;\
    DEBIAN_FRONTEND=noninteractive apt-get autoclean

RUN rm -rf /var/lib/apt/lists/* /etc/apache2/conf-available/other-vhosts-access-log.conf
RUN rm -rf /var/www/html ; mkdir -p /data ; ln -sf /data/wordpress /var/www/html

RUN wget -O /wordpress-6.2.2.zip https://wordpress.org/wordpress-6.2.2.zip

ADD --chmod=755 entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/php-fpm8.1", "--nodaemonize", "--force-stderr"]
EXPOSE 80
