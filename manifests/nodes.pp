# Be careful what you put here. This will go out to ALL puppet
# agents that connect to this server. The modules are
# specifically written for CentOS 6.2 and might break for
# older versions.
node default {
  
}

# This is a base class that includes basics for all servers.
node base {
  include motd, snmp, ldapclient, sudoers, ssh, users, groups
}

# this is a test node.
node 'test.example.com' inherits base {
  include network
}
