mv /etc/custom/openwrt-network /etc/config/network
mv /etc/custom/openwrt-dhcp /etc/config/dhcp
/etc/init.d/network reload 2>&1 /dev/null
/etc/init.d/dnsmasq reload 2>&1 /dev/null

# ntp
uci set system.ntp.enable_server='1'
/etc/init.d/sysntpd disable
/etc/init.d/ntpd enable
/etc/init.d/ntpd start

# use google dns-servers
uci -q delete dhcp.@dnsmasq[0].server
uci add_list dhcp.@dnsmasq[0].server="8.8.8.8"
uci add_list dhcp.@dnsmasq[0].server="8.8.4.4"
uci set dhcp.@dnsmasq[0].noresolv="1"
uci commit dhcp
/etc/init.d/dnsmasq restart