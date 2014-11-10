class apache (

  ### install.pp
  $package = "httpd",
  
  ## config.pp
  $apache_conf = "/etc/httpd/httpd.conf",
  $port = "80",
  $doc_root = "/var/www/example",
  $server_name = "www.example.com",
  
  ### service.pp
  $service = "httpd"

)

{

    anchor { "apache::begin": } ->
    class { "apache::install": } ->
    class { "apache::config": } ->
    class { "apache::service": } ->
    anchor { "apache::end": }

}

#class nginx {
#  
#  file { "/opt/nginx/conf/nginx.conf":
#    ensure         => present,
#    mode           => 0644,
#    template("nginx/nginx_conf") 
#    owner          => "root",
#    group          => "root"
#  }
#
#
#}
#