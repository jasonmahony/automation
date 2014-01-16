node default {
  include motd, ntp, ldapclient, sudoers, ssh, users, groups, network
}

node base {
  include motd, ntp, ldapclient, sudoers, ssh, users, groups, network

}