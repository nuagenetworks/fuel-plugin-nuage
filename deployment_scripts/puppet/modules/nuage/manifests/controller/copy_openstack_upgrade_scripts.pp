class nuage::controller::copy_openstack_upgrade_scripts {

  exec { 'copy_nuage_openstack_upgrade_scripts':
    command  => "python /etc/fuel/plugins/nuage-1.0/copy_nuage_openstack_upgrade_scripts_controller.py \
--host ${nuage::host} --username ${nuage::username} \
--password ${nuage::password} --copy_file ${nuage::copy_file} --plugin_version ${nuage::plugin_version}",
    provider  => 'shell',
    path  => '/usr/bin:/usr/sbin:/bin:/sbin',
    environment  => "HOME=/root",
  }
}
