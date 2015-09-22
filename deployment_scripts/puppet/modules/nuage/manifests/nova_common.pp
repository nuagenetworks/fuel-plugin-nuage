# Nova parameters for Nuage

class nuage::nova_common (
  $firewall_driver,
  $security_group_api,
  $libvirt_vif_driver,
  $vif_driver,
  $neutron_ovs_bridge,
) {

  #Setting nova.conf parameters on all Openstack nodes
  nova_config {
    'DEFAULT/firewall_driver': value => '$firewall_driver';
    'DEFAULT/security_group_api': value => '$security_group_api';
    'DEFAULT/libvirt_vif_driver' : value => '$libvirt_vif_driver';
    'DEFAULT/vif_driver': value => '$vif_driver';
    'neutron/ovs_bridge' : value => '$ovs_bridge';
  }
}
