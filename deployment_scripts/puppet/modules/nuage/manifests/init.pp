class nuage {

# General configuration
$settings = hiera('nuage')

$net_partition_name = $settings['nuage_net_partition_name']
$vsd_ip = $settings['nuage_vsd_ip']
$vsd_username = $settings['nuage_vsd_username']
$vsd_password = $settings['nuage_vsd_password']
$vsd_organization = $settings['nuage_vsd_organization']
$base_uri_version = $settings['nuage_base_uri_version']
$active_controller =  $settings['nuage_active_vsc_ip']
$backup_controller =  $settings['nuage_backup_vsc_ip']
}
