node default {
  include motd, snmp, ldapclient, sudoers, ssh, users, groups, network
}

# this is a test node.
node /^prd-app\d{2}.example.com$/ {
  include nginx, deployenv
}
