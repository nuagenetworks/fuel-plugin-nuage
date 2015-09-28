# Parameters for configuring Nuage Fuel plugin
class nuage {

$settings = hiera('nuage')

$net_partition_name = $settings['nuage_net_partition_name']
$vsd_ip = $settings['nuage_vsd_ip']
$vsd_username = $settings['nuage_vsd_username']
$vsd_password = $settings['nuage_vsd_password']
$vsd_organization = $settings['nuage_vsd_organization']
$base_uri_version = $settings['nuage_base_uri_version']
$active_controller =  $settings['nuage_active_vsc_ip']
$backup_controller =  $settings['nuage_backup_vsc_ip']

## Metadata settings
$metadata_port = $settings['metadata_port']
$nova_metadata_ip = $settings['nova_metadata_ip']
$nova_metadata_port = $settings['nova_metadata_port']
$nova_client_version = $settings['nova_client_version']
$nova_os_username = $settings['nova_os_username']
$nova_os_password = $settings['nova_os_password']
$nova_os_tenant_name = $settings['nova_os_tenant_name']
$nova_os_auth_url = $settings['nova_os_auth_url']
$metadata_agent_start_with_ovs = $settings['metadata_agent_start_with_ovs']
$nova_api_endpoint_type = $settings['nova_api_endpoint_type']

$neutron_settings=hiera('quantum_settings')
$metadata_secret=$neutron_settings['metadata']['metadata_proxy_shared_secret']
}
