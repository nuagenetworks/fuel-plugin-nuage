class nuage::compute::install_nuage_metadata_agent {

  package{ 'python-novaclient':
    ensure => present,
  }

  package{ 'nuage-metadata-agent':
    ensure => present,
    require => Package['python-novaclient']
  } ->
  file { '/etc/default/nuage-metadata-agent':
    content => template('nuage/nuage-metadata-agent.erb')
    notify  => Service['nuage-metadata-agent']
  }

  service { 'nuage-metadata-agent':
    subscribe => File['/etc/default/nuage-metadata-agent'],
  }
}
