class nuage::controller::restart_services {

  exec { 'restart neutron server':
    command  => 'service neutron-server restart',
    path     => '/usr/bin:/usr/sbin:/bin:/sbin',
    environment => "HOME=/root",
  }

  exec { 'restart nova conductor':
    command  => 'service nova-conductor restart',
    path     => '/usr/bin:/usr/sbin:/bin:/sbin',
    environment => "HOME=/root",
  }

  exec { 'restart nova scheduler':
    command  => 'service nova-scheduler restart',
    path     => '/usr/bin:/usr/sbin:/bin:/sbin',
    environment => "HOME=/root",
  }

  exec { 'restart nova api':
    command  => 'service nova-api restart',
    path     => '/usr/bin:/usr/sbin:/bin:/sbin',
    environment => "HOME=/root",
  }
}
