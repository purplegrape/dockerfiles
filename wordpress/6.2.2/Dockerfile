# syntax=docker/dockerfile:1
FROM docker.io/library/ubuntu:22.04
LABEL org.opencontainers.image.title=wordpress \
      org.opencontainers.image.version=6.2.2 \
      org.opencontainers.image.description="wordpress-6.2.2 & ubuntu-22.04 & apache-2.4.52 & php-8.1.2" \
      org.opencontainers.image.authors="purplegrape4@gmail.com"

RUN sed -i.bak 's/archive.ubuntu.com/cn.archive.ubuntu.com/g' /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update ;\
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y apache2 libapache2-mod-security2 libapache2-mod-php8.1 php8.1-opcache php8.1-curl php8.1-gd php8.1-mbstring php8.1-mysql php8.1-msgpack php8.1-xml php8.1-xmlrpc php8.1-uuid php8.1-soap php8.1-redis php8.1-zip tzdata unzip wget ;\
    DEBIAN_FRONTEND=noninteractive apt-get autoclean

RUN sed -i -e 's/ServerTokens OS/ServerTokens Prod/g' -e 's/ServerSignature On/ServerSignature Off/g' /etc/apache2/conf-available/security.conf
RUN sed -i -e '/AllowOverride/s/None/All/g' /etc/apache2/apache2.conf
RUN sed -i -e 's#ErrorLog.*#ErrorLog /proc/self/fd/2#g' /etc/apache2/apache2.conf /etc/apache2/sites-available/*.conf
RUN sed -i -e 's#CustomLog.*#CustomLog /proc/self/fd/1 combined#g' /etc/apache2/sites-available/*.conf
RUN rm -rf /var/lib/apt/lists/* /etc/apache2/conf-available/other-vhosts-access-log.conf
RUN rm -rf /var/www/html ; mkdir -p /data ; ln -sf /data/wordpress /var/www/html

RUN wget -O /wordpress-6.2.2.zip https://wordpress.org/wordpress-6.2.2.zip

ADD --chmod=755 entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
