node default {

}

node base {
  include motd, users, groups
}

node "dev-front.example.com" inherits base {
  include apache, devtools
}

node "dev-back.example.com" inherits base {
  include postgres
}

node "centos.localdomain" inherits base {
  include apache
}
