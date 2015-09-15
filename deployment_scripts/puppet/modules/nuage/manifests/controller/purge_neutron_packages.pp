class nuage::controller::purge_neutron_packages {

  define purge_neutron_package {
    package {'$name':
      ensure => "purged"
    }
  }

  purge_neutron_package { ['neutron-dhcp-agent', 'neutron-l3-agent', 'neutron-metadata-agent', 'neutron-plugin-openvswitch-agent', 'openvswitch-switch'] :}
}
