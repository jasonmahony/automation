class postgres::install {
	include postgres::params
	$postgres_version = $postgres::params::postgres_version
	$postgres_service = $postgres::params::postgres_service
	
	File { ensure => directory, owner => root, group => root, mode => 0755 }
  Package { ensure => installed, allow_virtual => true }
  $source = "puppet:///modules/postgres"
	
	package { "$postgres_version": }
  package { "$postgres_version-server": before => File['/db'] }
  package { "$postgres_version-libs": }
  package { "$postgres_version-contrib": }
  package { "$postgres_version-devel": }
	
	# set up pgsql directories (puppet won't create intermediate dirs)
	file { '/db': }
	file { '/db/pgsql': require => File['/db'] }
	file { '/db/pgsql/data': mode => 0700, owner => postgres, group => postgres, require => File['/db/pgsql'] }
	file { '/db/log': owner => postgres, group => postgres, require => File['/db'] }
  file { '/db/log/pg_xlog': owner => postgres, group => postgres, require => File['/db/log'] }
  file { "/etc/sysconfig/pgsql/$postgres_service": ensure => present, mode => 0644, source => "$source/conf", require => File["/etc/init.d/$postgres_service"] }
  file { "/etc/init.d/$postgres_service": ensure => present, source => "$source/postgres_init", require => Package["$postgres_version-server"] }
}