# Install Nuage VRS

class nuage::compute::install_nuage_vrs {

  package{ 'nuage-openvswitch-switch':
    ensure  => 'present',
    require => Package['python-twisted']
  }

  package{ 'openvswitch-switch':
    ensure => 'purged',
  }

  package{ 'python-twisted':
    ensure  => 'present',
    require => Package['openvswitch-switch']
  }
}
