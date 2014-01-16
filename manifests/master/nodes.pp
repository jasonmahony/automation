node default {
}

node base {
  include motd, ntp, ldapclient, sudoers, ssh, users, groups, network

}
