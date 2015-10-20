#!/usr/bin/env bash

cd /root
mkdir -p nuage-cms
tar -xzvf nuage-openstack-upgrade.tar.gz -C nuage-cms
cd nuage-cms
cluster_id=$(md5sum /root/cluster_id.txt | awk '{print $1}')
python set_and_audit_cms.py --neutron-config-file /etc/neutron/neutron.conf --plugin-config-file /etc/neutron/plugins/nuage/plugin.ini --name $cluster_id
