class sudoers {
  file {
    "/etc/sudoers": 
      source => "puppet:///modules/sudoers/restrictive", 
      owner => root,
      group => root,
      mode => 0440
  }
}