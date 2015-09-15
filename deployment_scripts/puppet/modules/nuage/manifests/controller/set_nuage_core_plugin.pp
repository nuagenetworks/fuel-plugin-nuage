class nuage::controller::set_nuage_core_plugin (
  $core_plugin,
  $service_plugins,
) {

  #Setting core plugin to be Nuage and disabling service plugins

  ini_setting { 'core_plugin':
    ensure  => present,
    path    => '/etc/neutron/neutron.conf',
    section => 'DEFAULT',
    setting => 'core_plugin',
    value   => $core_plugin,
  }

  ini_setting { 'service_plugins':
    ensure  => present,
    path    => '/etc/neutron/neutron.conf',
    section => 'DEFAULT',
    setting => 'service_plugins',
    value   => $service_plugins,
  }
}
