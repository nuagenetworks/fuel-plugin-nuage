define disable_neutron_service {
  service {'$name':
      ensure => "stopped"
  }
}

disable_neutron_service { ['neutron-dhcp-agent', 'neutron-l3-agent', 'neutron-metadata-agent',
    'neutron-plugin-openvswitch-agent', 'openvswitch-switch'] :}
