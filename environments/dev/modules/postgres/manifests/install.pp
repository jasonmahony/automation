class postgres::install {
	
	File { ensure => directory, owner => root, group => root, mode => 0755 }

	# set up pgsql directories (puppet won't create intermediate dirs)
	file { '/db': }
	file { '/db/pgsql': require => File['/db'] }
	file { '/db/pgsql/data': mode => 0700, owner => postgres, group => postgres, require => File['/db/pgsql'] }
	file { '/db/log': owner => postgres, group => postgres, require => File['/db'] }
  file { '/db/log/pg_xlog': owner => postgres, group => postgres, require => File['/db/log'] }

	unless $pgsql_version { notify { 'postgres database not yet initialized; not placing config files.' } }
  package { "$::postgres::packages": ensure => installed, allow_virtual => true }
#
#	package { "$::postgres::packages": ensure => installed, allow_virtual => false }
# 
  unless $pgsql_version {
    exec { "delete_default_configs":
		  command => "/bin/rm -f /db/pgsql/data/{postgresql.conf,pg_hba.conf}",
		  require => Package['$::postgres::packages']
    }
  }
    file { "/etc/sysconfig/pgsql/$::postgres::service": mode => 0644, source => "$source/conf" }
}