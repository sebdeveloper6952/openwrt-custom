FROM openwrtorg/rootfs

RUN mkdir /etc/custom && mkdir -p /var/lock
COPY . /etc/custom

RUN opkg update && opkg install ntpd