include vagrant_hosts

class {'apache2':
  disable_default_vhost => true,
}

class {'bunsho':
  rails_env => 'unstable',
  conf_set => 'vagrant',
  vhost_name => 'bunsho.vagrant.vm',
}
