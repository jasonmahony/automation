class apache::params {
  
  ### install.pp
   $package = "httpd"

   ## config.pp
   $port = "80"
   $doc_root = "/var/www/example"
   $server_name = "www.example.com"

   ### service.pp
   $service = "httpd" 
}

