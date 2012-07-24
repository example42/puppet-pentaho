# = Class: pentaho
#
# This is the main pentaho class
#
#
# == Parameters
#
# Module Specific params
#
# [*version*]
#   The pentaho version you want to install. The default install_source is
#   calculated according to itu.
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs pentaho using the OS common packages
#     - source  : Installs pentaho downloading and extracting a specific
#                 tarball or zip file
#     - puppi   : Installs pentaho tarball or file via Puppi, creating the
#                 "puppi deploy pentaho" command
#   Can be defined also by the variable $pentaho_install
#
# [*install_source*]
#   The URL from where to retrieve the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Default is from upstream developer site. Update the version when needed.
#   Can be defined also by the variable $pentaho_install_source
#
# [*install_destination*]
#   The base path where to extract the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Can be defined also by the variable $pentaho_install_destination
#
# [*install_precommand*]
#   A custom command to execute before installing the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Check pentaho/manifests/params.pp before overriding the default settings
#   Can be defined also by the variable $pentaho_install_precommand
#
# [*install_postcommand*]
#   A custom command to execute after installing the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Check pentaho/manifests/params.pp before overriding the default settings
#   Can be defined also by the variable $pentaho_install_postcommand
#
# [*init_script_template*]
#   The template to use to create the init script.
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, pentaho class will automatically "include $my_class"
#   Can be defined also by the variable $pentaho_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, pentaho main config file will have the param:
#   source => $source
#   Can be defined also by the variable $pentaho_source
#
# [*source_dir*]
#   If defined, the whole pentaho configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the variable $pentaho_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the variable $pentaho_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, pentaho main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the variable $pentaho_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the variable $pentaho_options
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the variable $pentaho_absent
#
# [*service_autorestart*]
#   Automatically restarts the pentaho service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $pentaho_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $pentaho_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the variables $pentaho_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for pentaho checks
#   Can be defined also by the variables $pentaho_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the variables $pentaho_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the variables $pentaho_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the variables $pentaho_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $pentaho_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for pentaho port(s)
#   Can be defined also by the (top scope) variables $pentaho_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling pentaho. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $pentaho_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $pentaho_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the variables $pentaho_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the variables $pentaho_audit_only
#   and $audit_only
#
# Default class params - As defined in pentaho::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of pentaho package
#
# [*service*]
#   The name of pentaho service
#
# [*service_status*]
#   If the pentaho service init script supports status argument
#
# [*process*]
#   The name of pentaho process
#
# [*process_args*]
#   The name of pentaho arguments. Used by puppi and monitor.
#   Used only in case the pentaho process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user pentaho runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $pentaho_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $pentaho_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include pentaho"
# - Call pentaho as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class pentaho (
  $root_password       = params_lookup( 'root_password' ),
  $guest_password      = params_lookup( 'guest_password' ),
  $replicator_password = params_lookup( 'replicator_password' ),
  $admin_password      = params_lookup( 'admin_password' ),
  $version             = params_lookup( 'version' ),
  $install             = params_lookup( 'install' ),
  $install_source      = params_lookup( 'install_source' ),
  $install_destination = params_lookup( 'install_destination' ),
  $install_precommand  = params_lookup( 'install_precommand' ),
  $install_postcommand = params_lookup( 'install_postcommand' ),
  $init_script_template = params_lookup( 'init_script_template' ),
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' )
  ) inherits pentaho::params {

  ### VARIABLES

  ### Variables reduced to booleans
  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $pentaho::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_service_enable = $pentaho::bool_disableboot ? {
    true    => false,
    default => $pentaho::bool_disable ? {
      true    => false,
      default => $pentaho::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $pentaho::bool_disable ? {
    true    => 'stopped',
    default =>  $pentaho::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $pentaho::bool_service_autorestart ? {
    true    => Service[pentaho],
    false   => undef,
  }

  $manage_file = $pentaho::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $pentaho::bool_absent == true
  or $pentaho::bool_disable == true
  or $pentaho::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $pentaho::bool_absent == true
  or $pentaho::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $pentaho::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $pentaho::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $pentaho::source ? {
    ''        => undef,
    default   => $pentaho::source,
  }

  $manage_file_content = $pentaho::template ? {
    ''        => undef,
    default   => template($pentaho::template),
  }

  ### Calculations of variables whoe value depends on different params
  $real_install_source = $pentaho::install_source ? {
    ''      => $pentaho::version ? {
      ''      => 'http://downloads.sourceforge.net/project/pentaho/Data%20Integration/4.2.1-stable/pdi-ce-4.2.1-stable.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpentaho%2F&ts=1339192051&use_mirror=heanet',
      default => "http://downloads.sourceforge.net/project/pentaho/Data%20Integration/${pentaho::version}-stable/pdi-ce-${pentaho::version}-stable.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpentaho%2F&ts=1339192051&use_mirror=heanet",
    },
    default => $pentaho::install_source,
  }

  $real_install_destination = $pentaho::install_destination ? {
    ''      => '/opt',
    default => $pentaho::install_destination,
  }

  $real_pentaho_dir = "$real_install_destination/pentaho"

  $real_config_file = $pentaho::config_file ? {
    ''      => "${pentaho::real_pentaho_dir}/config/pentaho-server-config.xml",
    default => $pentaho::config_file,
  }

  $real_config_dir = $pentaho::config_dir ? {
    ''      => $pentaho::install ? {
      package => $::operatingsystem ? {
        default => '/etc/pentaho',
      },
      default => "${pentaho::real_pentaho_dir}/config",
    },
    default => $pentaho::config_dir,
  }

  $real_data_dir = $pentaho::data_dir ? {
    ''      => $pentaho::install ? {
      package => '/usr/share/pentaho',
      default => "${pentaho::real_pentaho_dir}/databases",
    },
    default => $pentaho::data_dir,
  }

  $real_init_script_template = $pentaho::init_script_template ? {
    ''      => 'pentaho/pentaho.init.erb',
    default => $pentaho::init_script_template,
  }

  ### Managed resources
  # Installation is managed in a dedicated class
  require pentaho::install

  # Service is managed in a dedicated class
  require pentaho::service

  if ($pentaho::source or $pentaho::template) {
    file { 'pentaho.conf':
      ensure  => $pentaho::manage_file,
      path    => $pentaho::real_config_file,
      mode    => $pentaho::config_file_mode,
      owner   => $pentaho::config_file_owner,
      group   => $pentaho::config_file_group,
      require => Class['pentaho::install'],
      notify  => $pentaho::manage_service_autorestart,
      source  => $pentaho::manage_file_source,
      content => $pentaho::manage_file_content,
      replace => $pentaho::manage_file_replace,
      audit   => $pentaho::manage_audit,
    }
  }

  # The whole pentaho configuration directory can be recursively overriden
  if $pentaho::source_dir {
    file { 'pentaho.dir':
      ensure  => directory,
      path    => $pentaho::real_config_dir,
      require => Class['pentaho::install'],
      notify  => $foo::manage_service_autorestart,
      source  => $source_dir,
      recurse => true,
      purge   => $source_dir_purge,
      replace => $pentaho::manage_file_replace,
      audit   => $pentaho::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $pentaho::my_class {
    include $pentaho::my_class
  }

  ### Provide puppi data, if enabled ( puppi => true )
  if $pentaho::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'pentaho':
      ensure    => $pentaho::manage_file,
      variables => $classvars,
      helper    => $pentaho::puppi_helper,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $pentaho::bool_debug == true {
    file { 'debug_pentaho':
      ensure  => $pentaho::manage_file,
      path    => "${settings::vardir}/debug-pentaho",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}
