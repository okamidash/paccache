FROM nginx:alpine

LABEL maintainer="okamidash <okami@doubledash.org>"
LABEL description="NGINX Pacman Proxy Cache"
LABEL version="1.0.0"

ENV  DNS_SERVER=1.1.1.1 \
     SERVER_NAME=_ \
     PRIMARY_MIRROR='https://mirrors.ukfast.co.uk/sites/archlinux.org' \
     BACKUP_MIRROR='https://archlinux.uk.mirror.allworldit.com/archlinux'

COPY nginx.template /etc/nginx/nginx.template
COPY init.sh /var/init.sh
CMD /bin/sh -c "/var/init.sh && envsubst '\$DNS_SERVER \$SERVER_NAME \$PRIMARY_MIRROR \$BACKUP_MIRROR' < /etc/nginx/nginx.template > /etc/nginx/nginx.conf && nginx"
