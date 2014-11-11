class postgres::install {
	
	File { ensure => directory, owner => root, group => root, mode => 0755 }
  Package { ensure => installed, allow_virtual => false }
  $source = "puppet:///modules/postgres"
	
	# set up pgsql directories (puppet won't create intermediate dirs)
	file { '/db': }
	file { '/db/pgsql': require => File['/db'] }
	file { '/db/pgsql/data': mode => 0700, owner => postgres, group => postgres, require => File['/db/pgsql'] }
	file { '/db/log': owner => postgres, group => postgres, require => File['/db'] }
  file { '/db/log/pg_xlog': owner => postgres, group => postgres, require => File['/db/log'] }

	unless $pgsql_version { notify {'init_message': message => 'postgres database not yet initialized; not placing config files.' } }
  package { "${postgres_version}": }
  package { "${postgres_version}-server": }
  package { "${postgres_version}-contrib": }
  package { "${postgres_version}-lib": }
  package { "${postgres_version}-dev": }

  unless $pgsql_version {
    exec { "delete_default_configs":
		  command => "/bin/rm -f /db/pgsql/data/{postgresql.conf,pg_hba.conf}",
		  require => Package["${postgres_version}"]
    }
  }
    file { "/etc/sysconfig/pgsql/$::postgres::service": mode => 0644, source => "$source/conf" }
}