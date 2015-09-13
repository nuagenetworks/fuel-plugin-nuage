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
  neutron_config_nuage {
    'RESTPROXY/default_net_partition_name': value => $nuage::net_partition_name;
    'RESTPROXY/server':                     value => $nuage::vsd_ip;
    'RESTPROXY/serverauth':                 value => "$nuage::vsd_username:$nuage::vsd_password";
    'RESTPROXY/organization':               value => $nuage::vsd_organization;
    'RESTPROXY/auth_resource':              value => '/me';
    'RESTPROXY/serverssl':                  value => 'True';
    'RESTPROXY/base_uri':                   value => "/nuage/api/$nuage::base_uri_version";  
  } 
  
}
