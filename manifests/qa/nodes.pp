node default {
  include motd, snmp, ldapclient, sudoers, ssh, users, groups, network
}

# this is a test node.
node /^app\d{2}.qa.example.com$/ {
  include nginx, deployenv
}
