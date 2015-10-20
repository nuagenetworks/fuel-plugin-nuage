class nuage::controller::get_mos_cluster_id {

  exec { 'get_cluster_env_id':
    command  => "python /etc/fuel/plugins/nuage-1.0/get_mos_cluster_id.py \
--host ${nuage::host} --username ${nuage::username} \
--password ${nuage::password}",
    provider  => 'shell',
    path  => '/usr/bin:/usr/sbin:/bin:/sbin',
    environment  => "HOME=/root",
  }
}
