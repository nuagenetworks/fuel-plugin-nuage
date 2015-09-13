class neutron {
    # General configuration
#    $settings = hiera('nuage')
#
#    $net_partition_name = $settings['nuage_net_partition_name']
#    $vsd_ip = $settings['nuage_vsd_ip']
#    $vsd_username = $settings['nuage_vsd_username']
#    $vsd_password = $settings['nuage_vsd_password']
#    $vsd_organization = $settings['nuage_vsd_organization']
#    $base_uri_version = $settings['nuage_base_uri_version']

    $net_partition_name = OpenStack_default 
    $vsd_ip = 10.20.0.6:8443
    $vsd_username = csproot
    $vsd_password = csproot
    $vsd_organization = csp
    $base_uri_version = /nuage/api/v3_0 
}
