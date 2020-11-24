mv /etc/custom/openwrt-network /etc/config/network
mv /etc/custom/openwrt-dhcp /etc/config/dhcp
/etc/init.d/network reload
/etc/init.d/dnsmasq reload