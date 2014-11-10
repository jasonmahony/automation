node default {

}

node base {
  include motd
}

node "dev-front.example.com" inherits base {
  include nginx, devtools
}

node "dev-back.example.com" inherits base {
  include postgres
}

node "centos.localdomain" inherits base {
  include groups, apache
}
