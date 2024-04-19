package { 'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}

notify { 'Flask installation complete':
  require => Package['Flask'],
}
