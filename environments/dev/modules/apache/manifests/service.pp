define apache::service ( $apache_conf ) {
  
  service {"$::apache::service":
    ensure => running,
    subscribe => File[$::apache::apache_conf]
  }
  
  
}


