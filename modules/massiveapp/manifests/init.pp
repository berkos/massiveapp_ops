class massiveapp {

  $current_path = "/var/massiveapp/current"

  file {
    ["/var/massiveapp/", 
     "/var/massiveapp/shared/", 
     "/var/massiveapp/shared/config/"]:
      ensure => directory,
      owner  => vagrant,
      group  => vagrant,
      mode   => 775
  }

  file {
    "/var/massiveapp/shared/config/database.yml":
      ensure  => present,
      owner   => vagrant,
      group   => vagrant,
      mode    => 600,
      source  => "puppet:///modules/massiveapp/database.yml"
  }

  file {
    "/etc/logrotate.d/massiveapp.conf":
      owner   => root,
      group   => root,
      mode    => 755,
      content => template("massiveapp/massiveapp.logrotate.conf.erb")
  }

  cron {
    "massiveapp_logrotate":
      command => "/usr/bin/logrotate -f /etc/logrotate.d/massiveapp.conf",
      user    => "vagrant",
      hour    => [0,12],
      minute  => "0"
  }
  
  package {
    "bundler":
      provider => gem
  }
}