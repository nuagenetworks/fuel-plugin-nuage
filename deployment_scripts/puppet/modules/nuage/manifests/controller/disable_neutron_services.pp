define disable_neutron_service {
  service {"disabling $name":
      ensure => "stopped"
  }
}

disable_neutron_service { ['openstack-neutron-dhcp-agent', 'openstack-neutron-l3-agent', 'openstack-neutron-metadata-agent', 'openvswitch-vswitch'] :}
