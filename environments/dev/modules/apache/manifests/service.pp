define apache::service {

  service {"$::apache::service":
    ensure => running,
    subscribe => File['/etc/httpd/httpd.conf']
  }
}


