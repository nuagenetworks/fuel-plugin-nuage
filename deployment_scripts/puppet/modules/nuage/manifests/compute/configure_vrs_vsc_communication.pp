class nuage::compute::configure_vrs_vsc_communication {

  file_line { 'openvswitch active controller ip address':
    ensure      => present,
    line        => "ACTIVE_CONTROLLER=$neutron::active_controller",
    match       => 'ACTIVE_CONTROLLER=',
    path        => '/etc/default/openvswitch-switch',
  }

  file_line { 'openvswitch backup controller ip address':
    ensure      => present,
    line        => "BACKUP_CONTROLLER=$neutron::backup_controller",
    match       => 'BACKUP_CONTROLLER=',
    path        => '/etc/default/openvswitch-switch',
  }

  exec { 'restart ovs':
    command  => 'service nuage-openvswitch-switch restart',
    path     => '/usr/bin:/usr/sbin:/bin:/sbin',
    require  => File_Line['openvswitch active controller ip address'],
    environment => "HOME=/root",
  }
}
