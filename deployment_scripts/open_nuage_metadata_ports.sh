#!/usr/bin/env bash
 
lineno=$(iptables -nvL INPUT --line-numbers | grep "state RELATED,ESTABLISHED" | awk '{print $1}')
iptables -I INPUT $lineno -s 0.0.0.0/0 -p udp -m multiport --dports 8775 -m comment --comment "Nuage Metadata Agent listen port" -j ACCEPT

iptables-save > /etc/iptables/rules.v4
