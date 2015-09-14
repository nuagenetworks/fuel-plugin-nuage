class nuage::compute::restart_services {
 
  exec { 'restart nova compute':
    command  => 'service nova-compute restart',
    path     => '/usr/bin:/usr/sbin:/bin:/sbin',
    environment => "HOME=/root",
  }
}
