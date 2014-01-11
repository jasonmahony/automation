class postgresql {
  $pkgs = [ "postgresql", "postgresql-server", "postgresql-libs" ]
  File { owner => root, group => root, mode => 0644 }

  $source = "puppet:///modules/postgresql"
  
  package { $pkgs: 
    ensure => latest 
  }
  
  user {'postgres':
    comment => 'PostgreSQL Server',
    home    => '/var/lib/pgsql',
    shell => '/bin/bash',
    uid     => '26',
    gid     => '26',
  }
  
  # postgres server config file
    file { "/var/lib/pgsql/data/postgresql.conf": 
      mode         => 0600,
      owner        => postgres, 
      group        => postgres,
      ensure       => present, 
      source       => "$source/postgresql.conf"
    }
  
  # postgres client config file
    file { "/var/lib/pgsql/data/pg_hba.conf": 
      mode         => 0600,
      owner        => postgres, 
      group        => postgres,
      ensure       => present, 
      source       => "$source/pg_hba.conf"
    }
}    