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

  file {'/etc/neutron/plugins/nuage/plugin.ini':
    content => template('nuage/plugin.ini.erb'),
  } ->
  file {'/etc/neutron/plugin.ini':
    ensure => link,
    target  => '/etc/neutron/plugins/nuage/plugin.ini',
    require => Package['nuage-neutron']
  }

  neutron_config {
    'DEFAULT/core_plugin':             value => 'neutron.plugins.nuage.plugin.NuagePlugin';
    'DEFAULT/service_plugins':         value => '';
  } ->
}
