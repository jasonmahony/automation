class resque::worker inherits resque ( $resque_queue )
{
  File { mode => 644, ensure => present, content => template('resque/resque-generic.erb') }
  file { '/etc/init/resque-${name}.conf': }
}
