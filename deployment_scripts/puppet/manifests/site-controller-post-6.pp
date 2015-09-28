include nuage

class { 'nuage::controller::nova':
  firewall_driver    => 'nova.virt.firewall.NoopFirewallDriver',
  security_group_api => 'nova',
  libvirt_vif_driver => 'nova.virt.libvirt.vif.LibvirtGenericVIFDriver',
  neutron_ovs_bridge => 'alubr0',
}
