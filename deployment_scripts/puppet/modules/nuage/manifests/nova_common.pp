class nuage::nova_common (
  $firewall_driver,
  $security_group_api,
  $libvirt_vif_driver,
  $vif_driver,
  $neutron_ovs_bridge,
) {

  #Setting nova.conf parameters on all Openstack nodes

  ini_setting { 'firewall_driver':
  ensure  => present,
  path    => '/etc/nova/nova.conf',
  section => 'DEFAULT',
  setting => 'firewall_driver',
  value   => $firewall_driver,
  }

  ini_setting { 'security_group_api':
    ensure  => present,
    path    => '/etc/nova/nova.conf',
    section => 'DEFAULT',
    setting => 'security_group_api',
    value   => $security_group_api,
  }

  ini_setting { 'libvirt_vif_driver':
    ensure  => present,
    path    => '/etc/nova/nova.conf',
    section => 'DEFAULT',
    setting => 'libvirt_vif_driver',
    value   => $libvirt_vif_driver,
  }

  ini_setting { 'vif_driver':
    ensure  => present,
    path    => '/etc/nova/nova.conf',
    section => 'DEFAULT',
    setting => 'vif_driver',
    value   => $vif_driver,
  }

  ini_setting { 'ovs_bridge':
    ensure  => present,
    path    => '/etc/nova/nova.conf',
    section => 'neutron',
    setting => 'ovs_bridge',
    value   => $neutron_ovs_bridge,
  }
}
