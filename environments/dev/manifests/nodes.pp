node default {
}

node base {
  include motd, ntp, snmp, ldapclient, sudoers, ssh, users, groups, network
  $ruby_version = "2.1.0"  
}

node /^appdev\d{2}.example.com$/ inherits base {
  include nginx
}

node /^pgdev\{2}.example.com$/ inherits base {
  include postgres
}
