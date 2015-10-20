#!/usr/bin/env bash

cluster_id=$(md5sum /root/cluster_id.txt | awk '{print $1}')
python /etc/fuel/plugins/nuage-1.0/nuage_cms_id_stndby_controller.py --config-file /etc/neutron/plugins/nuage/plugin.ini --name $cluster_id
