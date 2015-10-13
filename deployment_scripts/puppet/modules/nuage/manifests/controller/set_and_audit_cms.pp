class nuage::controller::set_and_audit_cms {

  exec { 'set_and_audit_cms_id':
    command  => "python /root/nuage-cms/set_and_audit_cms.py \
--neutron-config-file /etc/neutron/neutron.conf \
--plugin-config-file /etc/neutron/plugins/nuage/plugin.ini \
--name ${nuage::mos_cluster}",
    provider  => 'shell',
    path  => '/usr/bin:/usr/sbin:/bin:/sbin',
    environment  => "HOME=/root",
  }
}
