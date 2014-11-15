class ntp {
  
  $source = "puppet:///modules/ntp"
  
  package { ntp: ensure => latest }
  
  service { ntpd:
    ensure     => 'running',
    enable     => 'true',
    hasstatus  => 'true',
    hasrestart => 'true',
    require    => Package['ntp'],
    subscribe  => File['/etc/ntp.conf'], 
  }
  
  file { '/etc/ntp.conf':
    owner  => 'root',
    group  => 'root',
    mode   => '644',
    source    => $source/ntp.conf,
    require    => Package['ntp'],
  }  
  
  file { '/etc/ntp/step-tickers':
    owner  => 'root',
    group  => 'root',
    mode   => '644',
    source    => $source/step-tickers,
    require    => Package['ntp'],
  }
  
}


