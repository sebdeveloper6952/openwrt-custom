mv /etc/custom/openwrt-system /etc/config/system
mv /etc/custom/openwrt-network /etc/config/network
/etc/init.d/network reload
mv /etc/custom/openwrt-dhcp /etc/config/dhcp
/etc/init.d/dnsmasq reload

# ntp
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

# firewall
mv /etc/custom/openwrt-firewall /etc/config/firewall
# uci set firewall.@forwarding[1]=forwarding
# uci set firewall@.forwarding[1].src='wan'
# uci set firewall@.forwarding[1].dest='lan'
# uci commit firewall
/etc/init.d/firewall reload