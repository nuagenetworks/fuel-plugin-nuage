class nuage::compute::configure_nuage_metadata_agent {

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

  ini_setting { 'METADATA_PORT':
    ensure  => present,
    path    => '/etc/default/nuage-metadata-agent',
    section => '',
    setting => 'METADATA_PORT',
    value   => $nuage::metadata_port,
  }

  ini_setting { 'NOVA_METADATA_IP':
    ensure  => present,
    path    => '/etc/default/nuage-metadata-agent',
    section => '',
    setting => 'NOVA_METADATA_IP',
    value   => $nuage::nova_metadata_ip,
  }

  ini_setting { 'NOVA_METADATA_PORT':
    ensure  => present,
    path    => '/etc/default/nuage-metadata-agent',
    section => '',
    setting => 'NOVA_METADATA_PORT',
    value   => $nuage::nova_metadata_port,
  }

  ini_setting { 'METADATA_PROXY_SHARED_SECRET':
    ensure  => present,
    path    => '/etc/default/nuage-metadata-agent',
    section => '',
    setting => 'METADATA_PROXY_SHARED_SECRET',
    value   => $nuage::metadata_proxy_shared_secret,
  }

  ini_setting { 'NOVA_CLIENT_VERSION':
    ensure  => present,
    path    => '/etc/default/nuage-metadata-agent',
    section => '',
    setting => 'NOVA_CLIENT_VERSION',
    value   => $nuage::nova_client_version,
  }

  ini_setting { 'NOVA_OS_USERNAME':
    ensure  => present,
    path    => '/etc/default/nuage-metadata-agent',
    section => '',
    setting => 'NOVA_OS_USERNAME',
    value   => $nuage::nova_os_username,
  }

  ini_setting { 'NOVA_OS_PASSWORD':
    ensure  => present,
    path    => '/etc/default/nuage-metadata-agent',
    section => '',
    setting => 'NOVA_OS_PASSWORD',
    value   => $nuage::nova_os_password,
  }

  ini_setting { 'NOVA_OS_TENANT_NAME':
    ensure  => present,
    path    => '/etc/default/nuage-metadata-agent',
    section => '',
    setting => 'NOVA_OS_TENANT_NAME',
    value   => $nuage::nova_os_tenant_name,
  }

  ini_setting { 'NOVA_OS_AUTH_URL':
    ensure  => present,
    path    => '/etc/default/nuage-metadata-agent',
    section => '',
    setting => 'NOVA_OS_AUTH_URL',
    value   => $nuage::nova_os_auth_url,
  }

  ini_setting { 'NUAGE_METADATA_AGENT_START_WITH_OVS':
    ensure  => present,
    path    => '/etc/default/nuage-metadata-agent',
    section => '',
    setting => 'NUAGE_METADATA_AGENT_START_WITH_OVS',
    value   => $nuage::metadata_agent_start_with_ovs,
  }

  ini_setting { 'NOVA_API_ENDPOINT_TYPE':
    ensure  => present,
    path    => '/etc/default/nuage-metadata-agent',
    section => '',
    setting => 'NOVA_API_ENDPOINT_TYPE',
    value   => $nuage::nova_api_endpoint_type,
  }
}
