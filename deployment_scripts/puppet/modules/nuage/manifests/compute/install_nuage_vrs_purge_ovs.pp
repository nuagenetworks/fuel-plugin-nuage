class nuage::compute::install_nuage_vrs_purge_ovs {

  package{ 'nuage-openvswitch-switch':
    ensure => 'present',
    require => Package['openvswitch-switch']
  }

  package{ 'openvswitch-switch':
    ensure => 'purged',
  }

  package{ 'python-twisted':
    ensure => 'present',
    require => Package['openvswitch-switch']
  }
}
