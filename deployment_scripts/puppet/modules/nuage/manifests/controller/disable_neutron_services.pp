class nuage::controller::disable_neutron_services { 

  service {'neutron-dhcp-agent':
    ensure => "stopped"
  }

  service {'neutron-l3-agent':
    ensure => "stopped"
  }

  service {'neutron-metadata-agent':
       ensure => "stopped"
  }

  service {'neutron-plugin-openvswitch-agent':
    ensure => "stopped"
  }

  service {'openvswitch-switch':
    ensure => "stopped"
  }
}
