class postgres::params {
  
   ## install.pp
   $packages = ["postgresql93", "postgresql93-server", "postgresql93-contrib", "postgresql93-devl", "postgresql93-libs"] 

   ## config.pp
   $lisen_address = "localhost"
   $max_connections = "80"
   $wal_level = "minimal"
   $archive_mode = "off"
   $archive_command_equals_line = ""
   $service = "postgresql-9.3"
   
}