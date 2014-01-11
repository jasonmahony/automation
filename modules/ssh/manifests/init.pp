class ssh {
  package { "openssh-clients": ensure => latest }
  
  package { "openssh": 
    ensure  => latest, 
    notify  => Service['sshd'] 
  }  
  
  file { "/etc/ssh/ssh_config":
    owner   => root,
    group   => root,
    mode    => 0644,
    ensure  => file,
    require => Package[ "openssh-clients" ]
  }
  
  package { "openssh-server":
    ensure  => latest, 
    require => Package[ "openssh-clients" ],
    notify  => Service[ "sshd" ]
  }  
 
  service { "sshd":
    name       => sshd,
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true
  }
  
  file { "/etc/ssh/keys": 
    mode         => 0644,
    ensure       => present,
    source       => "puppet:///modules/ssh/keys", 
    recurse      => true,
    recurselimit => 1,
    sourceselect => all,
    purge        => true,
    ignore       => 'root\.pub'
  }
  
  file { "/etc/ssh/sshd_config":
    notify  => Service["sshd"],  # this sets up the relationship
    mode    => 600,
    owner   => "root",
    group   => "root",
    require => Package["openssh-server"],
    source  => "puppet:///modules/ssh/sshd_config/restrictive",
  }
}
