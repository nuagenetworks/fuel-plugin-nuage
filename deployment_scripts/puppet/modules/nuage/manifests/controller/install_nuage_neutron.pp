package{ 'nuage-neutron':
  ensure => $package_ensure,
}

package{ 'nuage-openstack-neutronclient':
  ensure => $package_ensure,
}

package{ 'python-nuagenetlib':
  ensure => $package_ensure,
}
