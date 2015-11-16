#!/usr/bin/env bash
 
lineno=$(iptables -nvL INPUT --line-numbers | grep "state NEW,RELATED,ESTABLISHED" | awk '{print $1}')
iptables -I INPUT $lineno -s 0.0.0.0/0 -p tcp -m multiport --dports 8775 -m comment --comment "Nuage Metadata Agent listen port on the controller" -j ACCEPT

iptables-save > /etc/iptables/rules.v4

intf_list=$(ifconfig -a | grep "bond" | awk '{print $1}')

for intf in $intf_list
do
 (dhclient $intf) & sleep 10 ; kill $!
done
