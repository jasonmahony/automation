define apache::config ( $port, $doc_root, $server_name ) {
  
  file { "$::apache::apache_conf": 
    ensure => present,
    mode => 0644,
    content => template("apache/apache_conf.erb")
  }
  
}

