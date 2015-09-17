class nuage::compute::install_nuage_metadata_agent {

  package{ 'python-novaclient':
    ensure => present,
  }

  package{ 'nuage-metadata-agent':
    ensure => present,
    require => Package['python-novaclient']
  }
}
