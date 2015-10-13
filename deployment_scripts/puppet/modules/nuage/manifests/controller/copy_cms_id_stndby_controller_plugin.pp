class nuage::controller::copy_cms_id_stndby_controller_plugin {

  exec { 'copy_cms_id_stndby_controller':
    command  => "python /etc/fuel/plugins/nuage-1.0/nuage_cms_id_stndby_controller.py \
--config-file /etc/neutron/plugins/nuage/plugin.ini \
--name ${nuage::mos_cluster}",
    provider  => 'shell',
    path  => '/usr/bin:/usr/sbin:/bin:/sbin',
    environment  => "HOME=/root",
  }
}
