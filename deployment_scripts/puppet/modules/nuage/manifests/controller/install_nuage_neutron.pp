class nuage::controller::install_nuage_neutron {

  package{ 'nuage-neutron':
    ensure => present,
  }

  package{ 'nuage-openstack-neutronclient':
    ensure => present,
  }

  package{ 'python-nuagenetlib':
    ensure => present,
  }
}
