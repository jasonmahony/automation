class postgres (

	### install
	$packages = $postgres::params::packages,

    ### config
    $lisen_address = $postgres::params::listen_address,
    $max_connections = $postgres::params::max_connections,
    $wal_level = $postgres::params::wal_level,
    $archive_mode = $postgres::params::archive_mode,
    $archive_command_equals_line = $postgres::params::archive_command_equals_line,
    $service = $postgres::params::service,

  ) 
  inherits apache::params {

      anchor { "postgres::begin": } ->
      class { "postgres::install": } ->
      class { "postgres::config": } ->
      anchor { "postgres::end": }

  }