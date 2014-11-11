class postgres::config {
	
	File { ensure => present, owner => postgres, group => postgres, mode => 0600 }
	$source = "puppet:///modules/postgres"

    exec { "initialize_database":
		command => "/sbin/service $service initdb -X /db/log/pg_xlog",
		unless  => $pgsql_version
    }

    file { "/etc/init.d/$::postgres::service":
	  owner   => root,
	  group   => root,
    mode    => 0755,
    source  => "$source/postgres-init"       
    }
	
   # postgres server config file
    file { "/db/pgsql/data/postgresql.conf": content => template('postgres/postgreconf.erb') }
		
    # postgres client config file
    file { "/db/pgsql/data/pg_hba.conf": source => "$source/pg_hba.conf" }   

}