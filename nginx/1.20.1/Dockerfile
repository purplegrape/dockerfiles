# syntax=docker/dockerfile:1
FROM docker.io/almalinux/9-base as system-build

RUN mkdir /mnt/sys-root; \
    dnf install \
    --nogpgcheck --repoid=AppStream --repoid=BaseOS \
    --repofrompath='BaseOS,https://mirrors.aliyun.com/almalinux/9/BaseOS/$basearch/os/' \
    --repofrompath='AppStream,https://mirrors.aliyun.com/almalinux/9/AppStream/$basearch/os/' \
    --installroot /mnt/sys-root \
    --releasever 9 \
    --setopt install_weak_deps=false \
    --nodocs -y \
    coreutils-single bash curl-minimal procps-ng which nginx-core tzdata; \
    dnf --installroot /mnt/sys-root clean all; \
    rm -rf /mnt/sys-root/var/cache/* /mnt/sys-root/var/lib/{dnf,rpm} /mnt/sys-root/var/log/dnf* /mnt/sys-root/var/log/yum.* ; \
    rm -rf /mnt/sys-root/usr/share/{cracklib,doc,licenses,man} /mnt/sys-root/usr/share/dbus-* ; \
    rm -rf /mnt/sys-root/usr/bin/systemd-* /mnt/sys-root/usr/lib/systemd ;\
    rm -rf /mnt/sys-root/etc/nginx/*.default /mnt/sys-root/etc/nginx/fastcgi.conf /mnt/sys-root/etc/nginx/default.d

RUN /bin/date +%Y%m%d_%H%M > /mnt/sys-root/etc/BUILDTIME 

FROM scratch
LABEL org.opencontainers.image.title=nginx \
      org.opencontainers.image.version=1.20.1 \
      org.opencontainers.image.description="almalinux-9 & nginx-1.20.1"

COPY --from=system-build /mnt/sys-root/ /
COPY nginx.conf /etc/nginx/

RUN mkdir -p /var/log/nginx /var/lib/nginx /var/www/html
RUN chown -R nginx:nginx /var/log/nginx /var/lib/nginx
RUN ln -sf /dev/stderr /var/log/nginx/error.log
RUN ln -sf /dev/stdout /var/log/nginx/access.log

WORKDIR /var/www/html
CMD [ "/usr/sbin/nginx" ]
EXPOSE 80
