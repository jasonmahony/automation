class resque {

#  $rails_env = "dev"

  file { '/etc/init.d/resque': mode => 755, ensure => present, source => "puppet:///modules/resque/resque-init" }
  file { '/etc/init/resque-scheduler.conf': mode => 0644, ensure => present, source => "puppet:///modules/resque/resque-scheduler.conf" }

  resque::worker { 'event': resque_queue => "event" }
  resque::worker { 'signin': resque_queue => "signin" }

  package { 'resque': ensure => 'installed', provider => 'gem' }

}
