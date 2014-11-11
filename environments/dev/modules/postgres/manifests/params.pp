class postgres::params {
  
   ## install.pp
   $postgres_version = "postgresql93" 

   ## config.pp
   $lisen_address = "localhost"
   $max_connections = "80"
   $wal_level = "minimal"
   $archive_mode = "off"
   $archive_command_equals_line = ""
   $service = "postgresql-9.3"
   
}