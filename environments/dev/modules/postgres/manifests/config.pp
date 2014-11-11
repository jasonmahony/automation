class postgres::config {
	
	File { ensure => present, owner => postgres, group => postgres, mode => 0600 }
	$source = "puppet:///modules/postgres"
	
  # postgres server config file
  file { "/db/pgsql/data/postgresql.conf": content => template('postgres/postgresconf.erb') }		
  # postgres client config file
  file { "/db/pgsql/data/pg_hba.conf": source => "$source/pg_hba.conf" }   
  file { "/db/pgsql/data/pg_xlog": ensure => 'link', target => '/db/log/pg_xlog' }
}