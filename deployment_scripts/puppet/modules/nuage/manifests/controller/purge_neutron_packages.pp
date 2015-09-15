class nuage::controller::purge_neutron_packages {

  package {'neutron-dhcp-agent':
    ensure => "purged"
  }

  package {'neutron-l3-agent':
    ensure => "purged"
  }

  package {'neutron-metadata-agent':
    ensure => "purged"
  }

  package {'neutron-plugin-openvswitch-agent':
    ensure => "purged"
  }

  package {'openvswitch-switch':
    ensure => "purged"
  }
}
