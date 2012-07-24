# Class: pentaho::params
#
# This class defines default parameters used by the main module class pentaho
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to pentaho class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class pentaho::params {

  ### Module specific parameters
  $root_password = ''
  $guest_password = 'guest'
  $replicator_password = ''
  $admin_password = 'admin'
  $version = ''
  $install = 'source'
  $install_precommand = ''
  $install_postcommand = ''
  $init_script_template = ''

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'pentaho',
  }

  $service = $::operatingsystem ? {
    default => 'pentaho',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'java',
  }

  $process_args = $::operatingsystem ? {
    default => 'pentaho',
  }

  $process_user = $::operatingsystem ? {
    default => 'pentaho',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/pentaho.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/var/lib/pentaho',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/pentaho',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/pentaho/pentaho.log',
  }

  $port = '2424'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = ''
  $template = ''
  $options = ''
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $puppi = false
  $puppi_helper = 'java'
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/24'
  $firewall_dst = $::ipaddress
  $debug = false
  $audit_only = false

}
