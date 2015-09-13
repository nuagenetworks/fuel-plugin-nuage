class nuage::controller {
  
  package{ 'nuage-neutron':
    ensure => $package_ensure,
  }
 
  package{ 'nuage-openstack-neutronclient':
    ensure => $package_ensure,
  }
 
  package{ 'python-nuagenetlib':
    ensure => $package_ensure,
  }

  neutron_config {
    'DEFAULT/core_plugin':             value => 'neutron.plugins.nuage.plugin.NuagePlugin';
    'DEFAULT/service_plugins':         value => '';
  } ->
  file {'/etc/neutron/plugins/nuage/plugin.ini':
    content => template('nuage/plugin.ini.erb'),
    require => Package['nuage-neutron'],
  } ->
  file {'/etc/neutron/plugin.ini':
    ensure => link,
    target  => '/etc/neutron/plugins/nuage/plugin.ini',
  }

  service { 'neutron-server':
    ensure      => running,
    enable      => true,
    require     => [Package['nuage-neutron'],],
    subscribe   => [File['/etc/neutron/plugins/nuage/plugin.ini'],
                    File['/etc/neutron/plugin.ini']],
  }
}
