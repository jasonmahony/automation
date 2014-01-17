class sudoers {

  package { sudo: ensure => latest }

  file {
    "/etc/sudoers": 
      source => "puppet:///modules/sudoers/restrictive", 
      owner => root,
      group => root,
      mode => 0440
  }
}
