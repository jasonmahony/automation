define apache::service {

  service {"$::apache::service":
    ensure => running,
    subscribe => File[$::apache::apache_conf]
  }
}


