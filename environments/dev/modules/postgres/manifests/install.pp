class postgres::install {
	include postgres::params
	$postgres_version = $postgres::params::postgres_version
	$postgres_conf = $postgres::params::postgres_conf
  $postgres_init = $postgres::params::postgres_init
	
	File { ensure => directory, owner => root, group => root, mode => 0755, require => Package["$postgres_version-server"] }
  Package { ensure => installed, allow_virtual => false }
  $source = "puppet:///modules/postgres"
	
	package { "$postgres_version": }
  package { "$postgres_version-server": }
  package { "$postgres_version-libs": }
  package { "$postgres_version-contrib": }
  package { "$postgres_version-devel": }
	
	# set up pgsql directories (puppet won't create intermediate dirs)
	file { '/db': }
	file { '/db/pgsql': require => File['/db'] }
	file { '/db/pgsql/data': mode => 0700, owner => postgres, group => postgres, require => File['/db/pgsql'] }
	file { '/db/log': owner => postgres, group => postgres, require => File['/db'] }
  file { '/db/log/pg_xlog': owner => postgres, group => postgres, mode => 700, require => File['/db/log'] }
  file { "$postgres_conf": ensure => present, mode => 0644, source => "$source/conf" }
  file { "$postgres_init": ensure => present, source => "$source/postgres_init" }
}