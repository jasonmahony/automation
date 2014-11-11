class postgres::install {
	
	File { ensure => directory, owner => root, group => root, mode => 0755 }

	# set up pgsql directories (puppet won't create intermediate dirs)
	file { '/db': }
	file { '/db/pgsql': require => File['/db'] }
	file { '/db/pgsql/data': mode => 0700, owner => postgres, group => postgres, require => File['/db/pgsql'] }
	file { '/db/log': owner => postgres, group => postgres, require => File['/db'] }
    file { '/db/log/pg_xlog': owner => postgres, group => postgres, require => File['/db/log'] }
	
	notify { "postgres database not yet initialized; not placing config files.":}
   	package { "$::postgres::packages": ensure => installed, allow_virtual => true }

    exec { "delete_default_configs":
		command => "/bin/rm -f /db/pgsql/data/{postgresql.conf,pg_hba.conf}",
		unless  => $pgsql_version    
    }
}