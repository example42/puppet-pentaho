# Class: pentaho::user
#
# This class creates pentaho user
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by pentaho
#
class pentaho::user inherits pentaho {
  @user { $pentaho::process_user :
    ensure     => $pentaho::manage_file,
    comment    => "${pentaho::process_user} user",
    password   => '!',
    managehome => false,
    home       => $pentaho::real_pentaho_dir,
    shell      => '/bin/bash',
    before     => Group['pentaho'] ,
  }
  @group { $pentaho::process_user :
    ensure     => $pentaho::manage_file,
  }

  User <| title == $pentaho::process_user |>
  Group <| title == $pentaho::process_user |>

}
