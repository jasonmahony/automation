class network {
  $broadcast = broadcast($ipaddress, $netmask)
  
  file {'/etc/sysconfig/network-scripts/ifcfg-eth0': 
      ensure => present,
      content => template("network/ifcfg-eth0")  
  }
}