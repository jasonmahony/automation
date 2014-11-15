node default {

}

node base {
  include motd, users, groups, ssh, sudoers, ntp
}

node /^app\d{2}.example.com$/ inherits base {
  include nginx
}

node /^pg\{2}.example.com$/ inherits base {
  include postgres
}

node "centos.localdomain" {
  include postgres, sudoers, resque, ntp
}