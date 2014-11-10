define apache::config {

  file { '/etc/httpd/httpd.conf': 
    ensure => present,
    mode => 0644,
    content => template('apache/apache_conf.erb')
  } 
}

