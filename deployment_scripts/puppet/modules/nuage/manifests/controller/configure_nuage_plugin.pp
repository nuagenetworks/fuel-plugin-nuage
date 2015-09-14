class nuage::controller::configure_nuage_plugin {

  package{ 'nuage-neutron':
    ensure => present,
  }

  file { '/etc/neutron/plugins/nuage':
    ensure => 'directory',
  }

  file { '/etc/neutron/plugins/nuage/plugin.ini':
    ensure  => 'present',
    require => File['/etc/neutron/plugins/nuage'],
    content => template('nuage/plugin.ini.erb'),
  }

  #Create a symlink

  file {'/etc/neutron/plugin.ini':
    ensure  => link,
    target  => '/etc/neutron/plugins/nuage/plugin.ini',
    require => Package['nuage-neutron']
  }
}
