# Class: pentaho::service
#
# This class manages pentaho services
#
# == Variables
#
# Refer to pentaho class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by pentaho
#
class pentaho::service inherits pentaho {

  case $pentaho::install {

    package: {
      service { 'pentaho':
        ensure     => $pentaho::manage_service_ensure,
        name       => $pentaho::service,
        enable     => $pentaho::manage_service_enable,
        hasstatus  => $pentaho::service_status,
        pattern    => $pentaho::process,
        require    => Package['pentaho'],
      }
    }

    source,puppi: {
      service { 'pentaho':
        ensure     => $pentaho::manage_service_ensure,
        name       => $pentaho::service,
        enable     => $pentaho::manage_service_enable,
        hasstatus  => $pentaho::service_status,
        pattern    => $pentaho::process,
        require    => File['pentaho.init'],
      }
      file { 'pentaho.init':
        ensure  => $pentaho::manage_file,
        path    => '/etc/init.d/pentaho',
        mode    => '0755',
        owner   => $pentaho::config_file_owner,
        group   => $pentaho::config_file_group,
        require => Class['pentaho::install'],
        notify  => $pentaho::manage_service_autorestart,
        content => template($pentaho::real_init_script_template),
        audit   => $pentaho::manage_audit,
      }
    }

    default: { }

  }


  ### Service monitoring, if enabled ( monitor => true )
  if $pentaho::bool_monitor == true {
    monitor::port { "pentaho_${pentaho::protocol}_${pentaho::port}":
      protocol => $pentaho::protocol,
      port     => $pentaho::port,
      target   => $pentaho::monitor_target,
      tool     => $pentaho::monitor_tool,
      enable   => $pentaho::manage_monitor,
    }
    monitor::process { 'pentaho_process':
      process  => $pentaho::process,
      service  => $pentaho::service,
      pidfile  => $pentaho::pid_file,
      user     => $pentaho::process_user,
      argument => $pentaho::process_args,
      tool     => $pentaho::monitor_tool,
      enable   => $pentaho::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $pentaho::bool_firewall == true {
    firewall { "pentaho_${pentaho::protocol}_${pentaho::port}":
      source      => $pentaho::firewall_src,
      destination => $pentaho::firewall_dst,
      protocol    => $pentaho::protocol,
      port        => $pentaho::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $pentaho::firewall_tool,
      enable      => $pentaho::manage_firewall,
    }
  }

}
