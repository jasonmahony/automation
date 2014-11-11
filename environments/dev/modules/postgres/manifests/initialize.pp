class postgres::initialize {
  include postgres::params
  $postgres_version = $postgres::params::postgres_version

  unless $pgsql_version { 
    notify { 'postgres database not yet initialized; not placing config files.': }
    exec { "initialize_database": 
      command => "/sbin/service $postgres_version initdb -X /db/log/pg_xlog",
      require => Exec["delete_default_configs"]
    }
    exec { "delete_default_configs":
      command => "/bin/rm -f /db/pgsql/data/{postgresql.conf,pg_hba.conf}",
      require => Package["${postgres_version}-server"]
    }
  }
}
