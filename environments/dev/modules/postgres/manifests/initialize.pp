class postgres::initialize {
  include postgres::params
	$service = $postgres::params::service

  unless $pgsql_version { 
    notify { 'init_message': message => 'postgres database not yet initialized; not placing config files until initialized.' }
    exec { 'initialize_database': command => "/sbin/service ${service} initdb -X /db/log/pg_xlog" }
    exec { "delete_default_configs":
      command => "/bin/rm -f /db/pgsql/data/{postgresql.conf,pg_hba.conf}",
      before => Exec['initialize_database'] 
    }
  }
}
