# Puppet module: pentaho

## DEPRECATION NOTICE
This module is no more actively maintained and will hardly be updated.

Please find an alternative module from other authors or consider [Tiny Puppet](https://github.com/example42/puppet-tp) as replacement.

If you want to maintain this module, contact [Alessandro Franceschi](https://github.com/alvagante)


This is a Puppet pentaho module from the second generation of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-pentaho

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module.

For detailed info about the logic and usage patterns of Example42 modules read README.usage on Example42 main modules set.

## USAGE - Basic management

* Install pentaho using your distro package, if available

        class { "pentaho": }

* Install the latest pentaho version from upstream site

        class { "pentaho":
          install             => "source",
        }

* Install the latest pentaho version from upstream site using puppi. 
  You will have a 'puppi deploy pentaho' to deploy and update pentaho.

        class { "pentaho":
          install             => "puppi",
        }

* Install source from a custom url to a custom install_destination path.
  The following parameters apply both for "source" and "puppi" install methods.
  Puppi method may be used to manage deployment updates (given the $install_source is updated).
  By default install_source is set to upstream developer and install_destination to Web (App) server document root
  Pre and post installation commands may be already defined (check pentaho/manifests/params.pp) override them only if needed.
  Url_check and url_pattern are used for application checks, if monitor is enabled. Override only if needed.

        class { "pentaho":
          install             => "source",
          install_source      => "http://deploy.example42.com/pentaho/pentaho.tar.gz",
        }

* Remove pentaho

        class { "pentaho":
          absent => true
        }

* Enable auditing without without making changes on existing pentaho configuration files

        class { "pentaho":
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { "pentaho":
          source => [ "puppet:///modules/lab42/pentaho/wp-config.php-${hostname}" , "puppet:///modules/lab42/pentaho/wp-config.php" ], 
        }


* Use custom source directory for the whole configuration dir

        class { "pentaho":
          source_dir       => "puppet:///modules/lab42/pentaho/conf/",
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file 

        class { "pentaho":
          template => "example42/pentaho/wp-config.php.erb",      
        }

* Automaticallly include a custom subclass

        class { "pentaho:"
          my_class => 'pentaho::example42',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)
  Note that this option requires the usage of Example42 puppi module

        class { "pentaho": 
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with
  a puppi::helper define ) to customize the output of puppi commands 

        class { "pentaho":
          puppi        => true,
          puppi_helper => "myhelper", 
        }

* Activate automatic monitoring (recommended, but disabled by default)
  This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { "pentaho":
          monitor      => true,
          monitor_tool => [ "nagios" , "puppi" ],
        }

