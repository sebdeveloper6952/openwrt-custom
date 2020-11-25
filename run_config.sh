# copy custom configuration files
mv /etc/custom/openwrt-system /etc/config/system
mv /etc/custom/openwrt-network /etc/config/network
mv /etc/custom/openwrt-dhcp /etc/config/dhcp
mv /etc/custom/openwrt-firewall /etc/config/firewall

# reload services to take as input the new config files
/etc/init.d/network reload
/etc/init.d/dnsmasq reload
/etc/init.d/firewall reload

# ntp
/etc/init.d/sysntpd disable
/etc/init.d/ntpd enable
/etc/init.d/ntpd start