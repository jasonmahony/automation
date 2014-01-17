node default {
}

node base {
  include motd, ntp, snmp, ldapclient, sudoers, ssh, users, groups, network
  $ruby_version = "2.0.0-p353"  
}

node /^app\d{2}.example.com$/ inherits base {
  include nginx
}

node /^pg\{2}.example.com$/ inherits base {
  include postgres
}
