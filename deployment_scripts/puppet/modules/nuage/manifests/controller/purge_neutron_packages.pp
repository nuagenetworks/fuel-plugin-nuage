define purge_neutron_package {
 package {"removing $name":
      ensure => "purged"
 }
}

purge_neutron_package { ['neutron-dhcp-agent', 'neutron-l3-agent', 'neutron-metadata-agent', 'neutron-plugin-openvswitch'] :}
