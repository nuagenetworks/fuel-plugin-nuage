class nuage::controller::set_nuage_core_plugin (
  $core_plugin,
  $service_plugins,
) {

  neutron_config {
    'DEFAULT/core_plugin':             value => $core_plugin;
    'DEFAULT/service_plugins':         value => $service_plugins;
  }
}
