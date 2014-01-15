node default {
  include motd, snmp, ldapclient, sudoers, ssh, users, groups
}

# this is a test node.
node /^test\d{2}.example.com/ {
  include network
}
