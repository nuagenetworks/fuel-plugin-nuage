#!/usr/bin/env bash

lineno=$(iptables -nvL INPUT --line-numbers | grep "5900:6100" | awk '{print $1}')

iptables -R INPUT $lineno -p tcp -s 0.0.0.0/0 -m multiport --dports 5900:6100 -j ACCEPT

iptables-save > /etc/iptables/rules.v4
