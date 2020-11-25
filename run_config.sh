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
uci set dhcp.@dnsmasq[0].noresolv="0"
uci commit dhcp
/etc/init.d/dnsmasq restart

# Configure DNS provider
uci -q delete network.wan.dns
uci add_list network.wan.dns="8.8.8.8"
uci add_list network.wan.dns="8.8.4.4"
 
# Configure DNS6 provider
uci -q delete network.wan6.dns
uci add_list network.wan6.dns="2001:4860:4860::8888"
uci add_list network.wan6.dns="2001:4860:4860::8844"
 
# Disable peer DNS
uci set network.wan.peerdns="0"
uci set network.wan6.peerdns="0"
 
# Save and apply
uci commit network
/etc/init.d/network restart

# firewall
mv /etc/custom/openwrt-firewall /etc/config/firewall
/etc/init.d/firewall restart