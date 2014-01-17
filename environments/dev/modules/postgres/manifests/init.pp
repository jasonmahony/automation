class postgres {

  File { owner => root, group => root, mode => 0644 }

  $source = "puppet:///modules/postgres"

  user {'postgres':
    comment => 'PostgreSQL Server',
    home => '/db/pgsql',
    shell => '/bin/bash',
    uid => '26',
    gid => '26',
  }
  
# postgres server config file
  file { "/db/pgsql/data/postgresql.conf": 
    mode => 0600,
    owner => postgres, 
    group => postgres,
    ensure => present, 
    source => "$source/postgresql.conf"
  }

# postgres client config file
  file { "/db/pgsql/data/pg_hba.conf": 
    mode => 0600,
    owner => postgres, 
    group => postgres,
    ensure => present, 
    source => "$source/pg_hba.conf"
  }   

# set up pgsql directories (puppet won't create intermediate dirs)
  file { '/db': mode => 0755, ensure => directory	}
  file { '/db/pgsql': mode => 0755, ensure => directory }
  file { '/db/pgsql/data': mode => 0700, ensure => directory }
  file { '/db/log': mode => 755, ensure => directory, owner => postgres, group => postgres }
  file { '/db/log/pg_xlog': mode => 755, ensure => directory, owner => postgres, group => postgres }
  
  file {"/etc/init.d/postgresql-9.3":
    ensure  => present,
    mode    => 0755,
    source  => "$source/postgres-init"       
  }


  # place postgres config files only if a postgres server package is installed
  # otherwise initdb won't work
  # $pgsql_version is a custom fact -- see modules/postgres/lib/facter/pgsql_version.rb
 
  if $pgsql_version {
	  
  # postgres server config file
    file { "/db/pgsql/data/postgresql.conf": 
      mode         => 0600,
      owner        => postgres, 
      group        => postgres,
      ensure       => present, 
      source       => "$source/postgresql.conf"
    }
  # postgres client config file
    file { "/db/pgsql/data/pg_hba.conf": 
      mode         => 0600,
      owner        => postgres, 
      group        => postgres,
      ensure       => present, 
      source       => "$source/pg_hba.conf"
      }
    }

    else {
      notify { "postgres database not yet initialized; not placing config files.":}
      package { "postgresql93": ensure => installed }
      package { "postgresql93-server": ensure => installed }
      package { "postgresql93-libs": ensure => installed }
      package { "postgresql93-contrib": ensure => installed }
      package { "postgresql93-devel": ensure => installed }
    
    exec { "delete_default_configs":
    command => "/bin/rm -f /db/pgsql/data/{postgresql.conf,pg_hba.conf}"    
    } 
    
    exec { "initialize_database":
    command => "/sbin/service postgresql-9.3 initdb -X /db/log/pg_xlog"
    }
  }  
}
