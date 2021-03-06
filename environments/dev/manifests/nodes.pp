node default {

}

node base {
  include motd, users, groups, ssh, sudoers, ntp, snmp
}

node "dev-front.example.com" inherits base {
  include apache
}

node "dev-back.example.com" inherits base {
  include postgres
}

node "centos.localdomain" inherits base {
  include apache, postgres, resque
}
