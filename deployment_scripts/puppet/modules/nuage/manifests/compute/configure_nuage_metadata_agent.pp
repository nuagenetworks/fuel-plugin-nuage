class nuage::compute::configure_nuage_metadata_agent {

  package{ 'python-novaclient':
    ensure => present,
  }

  package{ 'nuage-metadata-agent':
    ensure => present,
    require => Package['python-novaclient']
  }

  file { '/etc/default/nuage-metadata-agent':
    ensure  => 'present',
    require => Package['nuage-metadata-agent'],
    content => template('nuage/nuage.metadata.agent.erb'),
  }

  ini_setting { 'use_forwarded_for':
    ensure  => present,
    path    => '/etc/nova/nova.conf',
    section => 'DEFAULT',
    setting => 'use_forwarded_for',
    value   => 'True',
  }

  ini_setting { 'instance_name_template':
    ensure  => present,
    path    => '/etc/nova/nova.conf',
    section => 'DEFAULT',
    setting => 'instance_name_template',
    value   => 'inst-%08x',
  }

  ini_setting { 'service_metadata_proxy':
    ensure  => present,
    path    => '/etc/nova/nova.conf',
    section => 'neutron',
    setting => 'service_metadata_proxy',
    value   => 'True',
  }

  ini_setting { 'metadata_proxy_shared_secret':
    ensure  => present,
    path    => '/etc/nova/nova.conf',
    section => 'neutron',
    setting => 'metadata_proxy_shared_secret',
    value   => $nuage::metadata_proxy_shared_secret,
  }
}
