# Class: pentaho::install
#
# This class installs pentaho
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
class pentaho::install inherits pentaho {

  case $pentaho::install {

    package: {
      package { 'pentaho':
        ensure => $pentaho::manage_package,
        name   => $pentaho::package,
      }
    }

    source: {

      $created_dirname = url_parse($pentaho::real_install_source,'filedir')

      require pentaho::user

      # Source zip does not contain a single parent dir :-I
      file { 'pentaho_dir':
        ensure => directory ,
        path   => "${pentaho::real_install_destination}/${created_dirname}" ,
      }

      puppi::netinstall { 'netinstall_pentaho':
        url                 => $pentaho::real_install_source,
        destination_dir     => "${pentaho::real_install_destination}/${created_dirname}" ,
        preextract_command  => $pentaho::install_precommand,
        postextract_command => "chown -R ${pentaho::process_user}:${pentaho::process_user} ${pentaho::real_install_destination}/${created_dirname}",
        extracted_dir       => 'databases',
        owner               => $pentaho::process_user,
        group               => $pentaho::process_user,
        require             => [ File['pentaho_dir'] , User[$pentaho::process_user] ],
      }

      file { 'pentaho_link':
        ensure => "${pentaho::real_install_destination}/${created_dirname}" ,
        path   => $pentaho::real_pentaho_dir ,
      }

    }

    puppi: {

      require pentaho::user

      puppi::project::archive { 'pentaho':
        source                   => $pentaho::real_install_source,
        deploy_root              => $pentaho::real_install_destination,
        predeploy_customcommand  => $pentaho::install_precommand,
        postdeploy_customcommand => $pentaho::install_postcommand,
        report_email             => 'root',
        user                     => $pentaho::process_user,
        auto_deploy              => true,
        enable                   => true,
        require                  => User[$pentaho::process_user],
      }

    }

    default: { }

  }

}
