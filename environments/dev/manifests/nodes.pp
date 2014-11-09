node default {

}

node base {
  include motd, ntp, snmp, ldapclient, sudoers, ssh, users, groups, network
}

node "dev-front.example.com" inherits base {
  include nginx, devtools
}

node "dev-back.example.com" inherits base {
  include postgres
}

node "centos.localdomain" {
  include motd
}
