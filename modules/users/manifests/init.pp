class users {
      # Declaring a dependency: we require several shared groups from the site::groups class (see below).
      Class[groups] -> Class[users]
      
      # Setting resource defaults for user accounts: 
        User { ensure => present,
          shell => '/bin/bash',
        }    
        # Declaring our accounts::user resources:
        user {'puppet':
          comment => 'Puppet Service Account',
          home    => '/var/lib/puppet',
          shell => '/sbin/nologin',
          uid     => '52',
          gid     => '52',
        }
        user {'jason':
          comment => 'System Operator',
          uid     => '777',
          gid     => '777',
          groups  => ['jason']
        }       
}