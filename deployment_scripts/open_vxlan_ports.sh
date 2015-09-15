#!/usr/bin/env bash

lineno=$(iptables -nvL INPUT --line-numbers | grep "5900:6100" | awk '{print $1}')
iptables -R INPUT $lineno -p tcp -s 0.0.0.0/0 -m multiport --dports 5900:6100 -j ACCEPT

lineno=$(iptables -nvL INPUT --line-numbers | grep "state RELATED,ESTABLISHED" | awk '{print $1}')
iptables -I INPUT $lineno -s 0.0.0.0/0 -p udp -m multiport --dports 4789 -m comment --comment "001 vxlan incoming" -j ACCEPT

iptables-save > /etc/iptables/rules.v4
